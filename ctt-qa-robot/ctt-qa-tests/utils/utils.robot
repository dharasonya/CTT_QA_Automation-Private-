*** Settings ***
Library    OperatingSystem
Library    Collections
Library    String
Library    BuiltIn
Resource    ../page-objects/login.robot
Resource    ../page-objects/space_selector.robot

*** Keywords ***
Login and Space Selection
    [Arguments]    ${KIBANA_BASE_URL}   ${USER_NAME}    ${PASSWORD}     ${SPACE_PATH}   ${POST_VALIDATION_XPATH}
    Login Control Tower Account    ${KIBANA_BASE_URL}   ${USER_NAME}    ${PASSWORD}     ${SPACE_PATH}
    Select Your Space   ${SPACE_PATH}   ${POST_VALIDATION_XPATH}

Get Data From CSV
    [Arguments]     ${csv_path}  ${column_name}
    ${file_content}=    Get File    ${csv_path}
    ${lines}=    Split To Lines    ${file_content}
    ${headers}=    Split String    ${lines[0]}    ,
    ${index}=     Get Index From List    ${headers}    ${column_name}

    @{values}=  Create List
    FOR    ${line}    IN    @{lines[1:]}
        ${cols}=    Split String    ${line}    ,
        ${value}=   Get From List    ${cols}    ${index}
        Append To List    ${values}    ${value}
    END
    RETURN    ${values}

Validate All Expected Visualizations Present
    [Arguments]    ${expected}    ${actual}
    @{missing_titles}=    Create List

    FOR    ${title}    IN    @{expected}
        IF    '${title}' not in ${actual}
            Append To List    ${missing_titles}    ${title}
        END
    END

    IF    ${missing_titles}
        Fail    ❌ Missing visualizations: ${missing_titles}
    END



