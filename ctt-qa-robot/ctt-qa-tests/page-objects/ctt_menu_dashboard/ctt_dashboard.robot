*** Settings ***
Library    SeleniumLibrary
Documentation    This is a page object file, all the automation implementation related to the dashboard page must be done here.
Resource    ../../resources/config.robot
 
*** Variables ***
${XPATH_UNABLE_TO_LOAD_VISUALIZATION}   xpath=//div[@role='alert']
${DATA_VIEW_ERROR}                      Failed to fetch
${XPATH_TAB_HOME}      xpath=//button[text()='Home']
${XPATH_TAB_HOME_VIEW}      xpath=(//*[text()='Projects'])[2]
${XPATH_TAB_PROJECTS}   xpath=//button[text()='Projects']
${XPATH_TAB_ACTIVE_PROJECTS}    xpath=//button[text()='Active Projects']
${XPATH_USERS}     xpath=//button[text()='Users']
${LOGGED_IN_USER_XPATH}    xpath=//div[contains(@class,'MuiTypography-subtitle2')]

*** Keywords ***
CTT Dashboard Visualization    
    [Arguments]    ${USER_NAME}  
    Wait Until Element Is Visible    ${LOGGED_IN_USER_XPATH}    timeout=${LONG_WAIT}
    ${LOGGED_IN_USER_ID}    Get Text    ${LOGGED_IN_USER_XPATH}
    Log To Console    Extracted User ID: ${LOGGED_IN_USER_ID}

    Should Be Equal As Strings    ${LOGGED_IN_USER_ID}    ${USER_NAME}    "❌ Login failed: User ID mismatch!"
# ${LOGGED_IN_USER_ID}    Get Text    xpath=//*[@id="root"]/div[1]/div[1]/header/div/div[2]/div/div/div/div

# *** Keywords ***
# CTT Dashboard Visualization    
#     [Arguments]    ${USER_NAME} 
#     Wait Until Element Is Visible    xpath=//div[contains(@class,'MuiTypography-subtitle2')]    timeout=${LONG_WAIT}
#     ${LOGGED_IN_USER_ID}    Get Text    xpath=//div[contains(@class,'MuiTypography-subtitle2')]
#     Should Be Equal As Strings    ${LOGGED_IN_USER_ID}    ${USER_NAME}    "Login failed: User ID mismatch!"

    