*** Settings ***
Library    SeleniumLibrary
Library    Collections
Library    String
Resource    ../page-objects/dev_tools.robot

*** Variables ***
${GET_COMMAND_ANOMALY_JOB}      GET /_ml/anomaly_detectors/PASS_ANOMALY_JOBID/_stats
${GET_COMMAND_DATAFEED_JOB}      GET /_ml/datafeeds/PASS_DATAFEED_JOBID/_stats

*** Keywords ***
Validate Datafeed Stats
    [Arguments]    ${json_text}
    ${json}=    Evaluate    __import__('json').loads("""${json_text}""")
    ${count}=    Get From Dictionary    ${json}    count
    ${datafeeds}=    Get From Dictionary    ${json}    datafeeds

    IF    ${count} <= 0
        Fail    ❌ No datafeeds found in the response.
    END


    ${first_feed}=    Get From List    ${datafeeds}    0
    ${state}=    Get From Dictionary    ${first_feed}    state

    Log    🔎 Datafeed count: ${count}, State: ${state}

    Run Keyword If    '${count}' == '1' and '${state}' == 'stopped'
    ...    Fail    ❌ Datafeed exists but is not running! Count=${count}, State=${state}
    ...    ELSE
    ...    Log    ✅ Datafeed validation passed.


Validate Job Stats
    [Arguments]    ${json_text}
    ${json}=    Evaluate    __import__('json').loads("""${json_text}""")
    ${count}=    Get From Dictionary    ${json}    count
    ${jobs}=     Get From Dictionary    ${json}    jobs

    IF    ${count} != 1
        Fail    ❌ Expected exactly 1 job in stats. Found: ${count}
    END

    ${job}=      Get From List    ${jobs}    0
    ${state}=    Get From Dictionary    ${job}    state
    Log    🔎 Job State: ${state}

    # Not Allowed: failed
    ${invalid_states}=    Create List    failed
    IF    "${state}" in ${invalid_states}
        Fail    ❌ State "${state}" is invalid. Must not be one of ${invalid_states}.
    END

    # Optional: Memory status validation
    ${model_size}=    Get From Dictionary    ${job}    model_size_stats
    ${memory_status}=   Get From Dictionary    ${model_size}    memory_status
    Log    🧠 Memory Status: ${memory_status}
    Should Be Equal    ${memory_status}    ok    ❌ Memory status is not OK: ${memory_status}

    # Optional: Categorization status validation
    ${cat_status}=  Get From Dictionary    ${model_size}    categorization_status
    Log    🧪 Categorization Status: ${cat_status}
    Should Be Equal    ${cat_status}    ok    ❌ Categorization status is not OK: ${cat_status}

    Log    ✅ ML Job Stats validation passed!

Validate ML Job From Dev Tools
    [Arguments]    ${anomaly_job_id}    ${datafeed_job_id}
    ${query_anomaly_job}=    Replace String    ${GET_COMMAND_ANOMALY_JOB}    PASS_ANOMALY_JOBID    ${anomaly_job_id}
    ${query_datafeed_job}=    Replace String    ${GET_COMMAND_DATAFEED_JOB}    PASS_DATAFEED_JOBID    ${datafeed_job_id}
    ${stats_json}=      Execute Dev Tools Query And Get Output      ${query_anomaly_job}
    Validate Job Stats    ${stats_json}
    ${datafeed_state_json}=     Execute Dev Tools Query And Get Output      ${query_datafeed_job}
    Validate Datafeed Stats    ${datafeed_state_json}

Loop And Validate ML Jobs From CSV
    [Arguments]    ${CSV_PATH_ML_JOB}
    ${csv}=    Get File    ${CSV_PATH_ML_JOB}
    ${lines}=    Split To Lines    ${csv}
    @{data_lines}=    Create List    @{lines[1:]}

    FOR    ${line}    IN    @{data_lines}
        ${columns}=           Split String    ${line}    ,
        ${length}=            Get Length      ${columns}

        IF    ${length} > 1
            ${anomaly_job_id}=    Strip String    ${columns[0]}
            ${datafeed_job_id}=   Strip String    ${columns[1]}
            Run Keyword And Continue On Failure    Validate ML Job From Dev Tools    ${anomaly_job_id}    ${datafeed_job_id}
        ELSE
            Log    ⚠️ Skipping malformed or empty line: ${line}
        END
    END


