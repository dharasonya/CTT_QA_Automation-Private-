*** Settings ***
Library    SeleniumLibrary
Documentation    This is a page object file, all the automation implementation related to the dashboard page must be done here.
Resource    ../resources/config.robot
Resource    ./menu_utils.robot
Resource    ../page-objects/ctt_dashboard.robot

*** Variables ***
${XPATH_CREATE_PROJECT}   xpath=//*[@id="root"]/div[1]/div[2]/main/div[2]/div[1]/div[2]/button[1][text()='Create Project']
${XPATH_UPDATE_ALL_CONFIG}      xpath=//*[@id="root"]/div[1]/div[2]/main/div[2]/div[1]/div[2]/button[2][text()='update all config']
${XPATH_ENTER_NAME}    id=Namecreate-user
${XPATH_ENTER_CLIENT_DESCRIPTION}    id=Descriptioncreate-user
${XPATH_ENTER_PROJECT_LEAD}    name=ProjectLead
${XPATH_SELECT_PROJECT_LEAD}   xpath=//*[@id='undefinedcreate-user-listbox']
${XPATH_ENTER_PROJECT_GROUP}    name=ProjectGroup
${XPATH_ENTER_DOMAIN}    name=Domain
${XPATH_SELECT_DOMAIN}    xpath=//*[@id='undefinedcreate-user-listbox']
${XPATH_SAVE_BUTTON}    xpath=/html/body/div[4]/div[3]/div/div[2]/button[2]
${XPATH_CANCEL_BUTTON}    xpath=//*[text()='Cancel']
${XPATH_ADD_POPUP_VIEW}    xpath=(//*[@data-testid='AddCircleIcon'])[2]
${XPATH_PROJECTS_TAB_VIEW}    xpath=(//*[text()='Projects'])[2]
${XPATH_ON_SAVE_MSG}    xpath=//div[@role='alert']/div

*** Keywords ***
Go To Tab Projects
    Wait Until Element Is Visible    ${XPATH_TAB_PROJECTS}    timeout=${LONG_WAIT}
    Click Element                    ${XPATH_TAB_PROJECTS}
    Wait Until Element Is Visible    ${XPATH_PROJECTS_TAB_VIEW}    timeout=${MEDIUM_WAIT}

Create Project
    Click Element                    ${XPATH_CREATE_PROJECT}
    # Wait Until Element Is Visible    ${XPATH_ADD_POPUP_VIEW}    timeout=${SHORT_WAIT}

Assign and Complete Project Assignment
    [Arguments]    ${CREATE_PROJECT_NAME}    ${CLIENT_DESCRIPTION}    ${PROJECT_LEAD}    ${PROJECT_GROUP}    ${DOMAIN}
    Input text    ${XPATH_ENTER_NAME}    ${CREATE_PROJECT_NAME} 
    Input text    ${XPATH_ENTER_CLIENT_DESCRIPTION}    ${CLIENT_DESCRIPTION}
    Input Text    ${XPATH_ENTER_PROJECT_LEAD}    ${PROJECT_LEAD}
    Wait Until Element Is Visible    ${XPATH_SELECT_PROJECT_LEAD}    timeout=${MEDIUM_WAIT}
    Click Element    ${XPATH_SELECT_PROJECT_LEAD}
    Input text    ${XPATH_ENTER_PROJECT_GROUP}    ${PROJECT_GROUP} 
    Input text    ${XPATH_ENTER_DOMAIN}    ${DOMAIN}
    Wait Until Element Is Visible    ${XPATH_SELECT_DOMAIN}    timeout=${MEDIUM_WAIT}
    Click Element    ${XPATH_SELECT_DOMAIN}
    Click Element    ${XPATH_SAVE_BUTTON}
    Wait Until Element Is Visible    ${XPATH_ON_SAVE_MSG}    timeout=${LONG_WAIT}
    Log    ${XPATH_ON_SAVE_MSG}
    Wait Until Element Is Visible    ${XPATH_ON_SAVE_MSG}    timeout=${MEDIUM_WAIT}
    ${XPATH_ON_SAVE_MSG}    Get Text    ${XPATH_ON_SAVE_MSG}
    Log To Console    Extracted On Save Message: ${XPATH_ON_SAVE_MSG}
    Should Be Equal As Strings    ${XPATH_ON_SAVE_MSG}    Project Created Successfully    "Save action failed: Unexpected message variation!"


