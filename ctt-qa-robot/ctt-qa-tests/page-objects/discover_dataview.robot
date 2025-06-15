*** Settings ***
Library    SeleniumLibrary
Documentation    This is a page object file, all the automation implementation related to the discover dataview page must be done here.Dataview should not have multiple values in the drop down for the given input text.
Resource    ../resources/config.robot
Resource    ./xpath_constants.robot
Resource    ../utils/string_constants.robot
Resource    ./dashboard.robot
Library    OperatingSystem
Library    BuiltIn
Library    Collections
Library    String

*** Keywords ***
Click Dataview Drop Down
    Wait Until Element Is Visible    ${XPATH_DATAVIEW_DROPDOWN}    timeout=${LONG_WAIT}
    Click element    ${XPATH_DATAVIEW_DROPDOWN}

Search Dataview
    [Arguments]    ${INPUT_TEXT}    ${N_DAYS_AGO}=14
    Wait Until Element Is Visible    ${XPATH_DATAVIEW_INPUT_TEXT}    timeout=${LONG_WAIT}
    Clear element text    ${XPATH_DATAVIEW_INPUT_TEXT}
    Input text    ${XPATH_DATAVIEW_INPUT_TEXT}      ${INPUT_TEXT}
    Sleep    0.5s
    Press Keys    ${XPATH_DATAVIEW_INPUT_TEXT}    RETURN
    Sleep    2s
    ${is_present}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${XPATH_DATE_QUICK_SELECTOR}    timeout=5s

    IF    ${is_present}
        Log    ✅ Time picker button found!
        Click Element    ${XPATH_DATE_QUICK_SELECTOR}
        Set Start Date To N Days Ago    ${N_DAYS_AGO}
    ELSE
        Log    ⛔ Time picker button not found!
    END


Validate Discover Errors
    ${has_error}=    Run Keyword And Return Status
    ...    Run Keyword    Check Discover Error Conditions
    IF    ${has_error}
        Log    ❌ Discover page has errors after data view selection
    ELSE
        Log    ✅ Discover page loaded correctly
    END

Check Discover Error Conditions
    ${err1}=    Run Keyword And Return Status
    ...    Page Should Contain Element    ${XPATH_VAL_NO_RESULTS_MATCH}
    ${err2}=    Run Keyword And Return Status
    ...    Page Should Contain Element    ${XPATH_VAL_RUNTIME_FIELD}
    ${err3}=    Run Keyword And Return Status
    ...    Page Should Contain Element    ${XPATH_VAL_UNABLE_TO_LOAD_VIZ}

    IF    ${err1} or ${err2} or ${err3}
        Fail    ❌ Discover error detected
    END


Search Dataview for CSV Input
    [Arguments]    ${DATA_VIEW_CSV_INPUT}
    ${file_content}=    Get File    ${DATA_VIEW_CSV_INPUT}
    ${lines}=    Split To Lines    ${file_content}
    ${headers}=  Split String    ${lines[0]}    ${STRING_COMA}
    ${idx_name}=    Get Index From List    ${headers}    ${STRING_DATA_VIEW}
    ${idx_days}=    Get Index From List    ${headers}    ${STRING_NO_OF_DAYS_AGO}

    FOR    ${line}    IN    @{lines[1:]}
        ${columns}=    Split String    ${line}      ${STRING_COMA}
        ${data_view}=    Get From List    ${columns}    ${idx_name}
        ${days_ago}=     Get From List    ${columns}    ${idx_days}
        ${data_view}=    Strip String    ${data_view}
        ${days_ago}=     Strip String    ${days_ago}

        Log    🔎 Checking DataView: ${data_view} for ${days_ago} days ago
        Sleep    ${MEDIUM_WAIT}
        Click Dataview Drop Down
        Run Keyword And Continue On Failure    Search Dataview    ${data_view}      ${days_ago}
        Run Keyword And Continue On Failure    Validate Discover Errors
    END

