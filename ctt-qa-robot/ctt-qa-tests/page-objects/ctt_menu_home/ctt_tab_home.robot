*** Settings ***
Library    SeleniumLibrary
Documentation    This is a page object file, all the automation implementation related to the dashboard page must be done here.
Resource    ../../resources/config.robot
Resource    ../../page-objects/ctt_menu_dashboard/ctt_dashboard.robot

*** Variables ***
${XPATH_ON_SAVE_MSG}    xpath=//div[@role='alert']/div

${PROJECT_GROUP}    
${XPATH_ON_CLICK_PROJECT_GROUP}    xpath=//p[@class='MuiTypography-root MuiTypography-body1 css-q7o8s0']
# (//p[@class='MuiTypography-root MuiTypography-body1 css-q7o8s0'])[1]
# ...    /html/body/div[1]/div[1]/div[2]/main/div[2]/div[1]/div[2]/div[1]/div[1]/div[2]/div[1]/div[1]/div
${XPATH_OPEN_PROJECTS}    xpath=//div[@class='MuiCollapse-root MuiCollapse-vertical MuiCollapse-entered css-c4sutr']//div[@class='MuiCollapse-wrapper MuiCollapse-vertical css-hboir5']//div[@class='MuiCollapse-wrapperInner MuiCollapse-vertical css-8atqhb']//div[@id='panel1bh-content']//div[@class='MuiAccordionDetails-root css-u7qq7e']//div//div//div[@class='MuiPaper-root MuiPaper-elevation MuiPaper-rounded MuiPaper-elevation1 MuiAccordion-root MuiAccordion-rounded MuiAccordion-gutters css-17njzbh']//div[@id='panel1bh-header']//div[@class='MuiAccordionSummary-content MuiAccordionSummary-contentGutters css-l0jafl']//div//button[@aria-label='Details']

*** Keywords ***
Go To Tab Home
    Wait Until Element Is Not Visible    ${XPATH_ON_SAVE_MSG}    timeout=${LONG_WAIT}
    Click Element    ${XPATH_TAB_HOME}
    Wait Until Element Is Visible    ${XPATH_TAB_HOME_VIEW}    timeout=${SHORT_WAIT}

View Created Project
    [Arguments]    ${PROJECT_GROUP}    ${CREATE_PROJECT_NAME}
    Wait Until Page Contains    Projects    timeout=${LONG_WAIT}
    Log To Console    Extracted On Project Group Name: ${PROJECT_GROUP}

    ${elements}    Get WebElements    ${XPATH_ON_CLICK_PROJECT_GROUP}
    FOR    ${element}    IN    @{elements}
        ${text}    Get Text    ${element}
        Log To Console    Extracted Groups: ${text}
        
        IF    '${text}' == '${PROJECT_GROUP}'
            Click Element    ${element}
            Log To Console    Clicked on matching element: ${text}
            BREAK
        END
    END

    Log To Console    Extracted On Project Name: ${CREATE_PROJECT_NAME}
    ${elements}    Get WebElements    ${XPATH_OPEN_PROJECTS}
    
    FOR    ${element}    IN    @{elements}
        ${text}    Get Text    ${element}
        # Split the text and remove the last part (version number)
        ${project_parts}    Evaluate    str('${text}').rsplit(" ", 1)
        ${final_name}    Set Variable    ${project_parts}[0]  # Extracts project name without version number

        Log To Console    Extracted Projects Text: ${final_name}
        
        IF    '${final_name}' == '${CREATE_PROJECT_NAME}'
            Click Element    ${element}
            Log To Console    Clicked on matching element: ${final_name}
            BREAK
        END
    END
    


    



