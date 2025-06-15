*** Settings ***
Library    RequestsLibrary
Library    Collections
Library    JSONLibrary
Library    String
Library    OperatingSystem
Library    BuiltIn
Library    DateTime
Resource    ../utils/string_constants.robot

*** Keywords ***

Fetch All Visualizations In Dashboard
    [Arguments]    ${KIBANA_BASE_URL}   ${KIBANA_SPACE}     ${HEADERS}      ${DASHBOARD_ID}
    Create Session    kibana    ${KIBANA_BASE_URL}    headers=${HEADERS}
    ${resp}=    GET On Session    kibana    /s/${KIBANA_SPACE}/api/saved_objects/dashboard/${DASHBOARD_ID}
    Should Be Equal As Integers    ${resp.status_code}    200

    ${dashboard}=    Convert To Dictionary    ${resp.json()}
    ${references}=   Get From Dictionary    ${dashboard}    references
    @{titles}=       Create List

    FOR    ${ref}    IN    @{references}
        ${type}=    Get From Dictionary    ${ref}    type
        Append To List    ${titles}    ${ref}
    END

    @{viz_titles}=    Create List
    FOR    ${ref}    IN    @{titles}
        ${title}=    Fetch Visualization Title By Id    ${ref}    ${KIBANA_SPACE}
        Append To List    ${viz_titles}    ${title}
    END

    RETURN    ${viz_titles}


Fetch Visualization Title By Id
    [Arguments]    ${ref}   ${KIBANA_SPACE}
    ${id}=    Get From Dictionary    ${ref}    id
    ${type}=    Get From Dictionary    ${ref}    type
    ${viz_resp}=    GET On Session    kibana    /s/${KIBANA_SPACE}/api/saved_objects/${type}/${id}
    Should Be Equal As Integers    ${viz_resp.status_code}    200
    ${viz}=    Convert To Dictionary    ${viz_resp.json()}
    ${title}=  Get From Dictionary    ${viz['attributes']}    title
    Log    📊 Title: ${title}
    RETURN    ${title}

Validate Alert Rules From CSV
    [Arguments]  ${RULE_CSV_PATH}  ${KIBANA_BASE_URL}  ${KIBANA_SPACE}  ${REQ_HEADERS}  ${COLUMN_NAME}  ${PAGE_SIZE}=50
    ${file_content}=    Get File    ${RULE_CSV_PATH}
    ${lines}=    Split To Lines    ${file_content}
    ${headers}=    Split String    ${lines[0]}    ,
    ${index}=     Get Index From List    ${headers}    ${COLUMN_NAME}
    @{rules}=    Create List
    FOR    ${line}    IN    @{lines[1:]}
        ${columns}=    Split String    ${line}    ,
        ${rule_name}=  Strip String    ${columns[0]}
        Append To List    ${rules}    ${rule_name}
    END

    Log Many    Rules to validate:    ${rules}

    # Loop and validate each rule without stopping on fail
    FOR    ${rule}    IN    @{rules}
        Log    🔍 Validating Rule: ${rule}
        ${status}    ${message}=    Run keyword and continue on failure
        ...     Validate Rule Is Enabled And Succeeded
        ...    ${rule}    ${KIBANA_BASE_URL}    ${KIBANA_SPACE}    ${REQ_HEADERS}   ${PAGE_SIZE}
        Log    ✅ ${rule} → ${status}: ${message}
    END


Validate Rule Is Enabled And Succeeded
    [Arguments]    ${RULE_NAME}    ${KIBANA_BASE_URL}    ${KIBANA_SPACE}    ${REQ_HEADERS}  ${PAGE_SIZE}=50
    Create Session    kibana    ${KIBANA_BASE_URL}    headers=${REQ_HEADERS}
    ${encoded_rule}=    Replace String    ${RULE_NAME}    ${SPACE}    %20
    ${endpoint}=    Set Variable    /s/${KIBANA_SPACE}/api/alerting/rules/_find?search=${encoded_rule}&search_fields=name&per_page=${PAGE_SIZE}

    ${resp}=    GET On Session    kibana    ${endpoint}
    Should Be Equal As Integers    ${resp.status_code}    200

    ${json}=    Convert To Dictionary    ${resp.json()}
    ${rules}=    Get From Dictionary    ${json}    data

    ${rule_found}=    Set Variable    False

    FOR    ${rule}    IN    @{rules}
        ${name}=    Get From Dictionary    ${rule}    name
        Log    🔍 ${name}
        Log    🔍 ${RULE_NAME}
        Log    🔍 Comparing: '${name}' == '${RULE_NAME}'
        Run Keyword If    '${name}' == '${RULE_NAME}'    Check Enabled And Succeeded    ${rule}
        Run Keyword If    '${name}' == '${RULE_NAME}'    Set suite variable    ${rule_found}    True
        Run Keyword If    '${name}' == '${RULE_NAME}'    Exit For Loop
    END

    IF    not ${rule_found}
        Fail    ❌ Rule '${RULE_NAME}' not found in API response.
    END

Check Enabled And Succeeded
    [Arguments]    ${rule}
    ${enabled}=    Get From Dictionary    ${rule}    enabled
    Should Be True    ${enabled}    ❌ Rule is not enabled.

    ${last_run}=    Get From Dictionary    ${rule}    last_run
    ${outcome}=     Get From Dictionary    ${last_run}    outcome
    Should Be Equal    ${outcome}    succeeded    ❌ Last run outcome is not 'succeeded'. Found: ${outcome}


Validate Data View Has Documents
    [Arguments]    ${KIBANA_BASE_URL}    ${KIBANA_SPACE}    ${HEADERS}    ${INDEX_PATTERN}    ${HOURS_AGO}=1    ${PAGE_SIZE}=1

    ${now}    Evaluate  '{dt:%A}, {dt:%B} {dt.day}, {dt.year}'.format(dt=datetime.datetime.now())    modules=datetime
    ${from_time}=    Evaluate    '{dt:%Y-%m-%dT%H:%M:%S.000Z}'.format(dt=datetime.datetime.now() - datetime.timedelta(hours=${HOURS_AGO}))    modules=datetime

    ${query}=    Create Dictionary
    ...    index=${INDEX_PATTERN}
    ...    size=${PAGE_SIZE}
    ...    query={"bool":{"filter":[{"range":{"generatedOn":{"gte":"${from_time}","lte":"${now}","format":"strict_date_optional_time"}}}]}}

    ${endpoint}=    Set Variable    /s/${KIBANA_SPACE}/internal/search/es

    Create Session    kibana    ${KIBANA_BASE_URL}    headers=${HEADERS}
    ${response}=     POST On Session    kibana    ${endpoint}    json=${query}
    Should Be Equal As Integers    ${response.status_code}    200

    ${json}=     Convert To Dictionary    ${response.json()}
    ${hits}=     Get From Dictionary    ${json}    rawResponse
    ${hits_root}=    Get From Dictionary    ${hits}    hits
    ${total}=        Get From Dictionary    ${hits_root}    total

    Log    🔍 Raw response: ${hits}
    Log    🔍 Hits Root: ${hits_root}
    Log    🔍 Total: ${total}

    Should Be True    ${total} > 0    ❌ No documents found for ${INDEX_PATTERN} in last ${HOURS_AGO} hour(s).
    Log    ✅ Found ${total} documents for ${INDEX_PATTERN}
