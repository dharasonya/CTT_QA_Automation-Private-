*** Settings ***
Library    SeleniumLibrary
Documentation    This is a page object file, all the automation implementation related to the logincls page must be done here.
Resource    ../resources/config.robot

*** Variables ***
#Native Login Element Path
${NATIVE_LOGIN_LINK_ELEMENT_PATH}       xpath= //p[normalize-space()='Pivotree Control Tower Account']

#Nativ Login Username, Password Boxes and Login submit Xpath

${CTT_LOGIN_PAGE_VIEW}               xpath= //h1[@class='css-17vm8mw']
${CTT_LOGIN_USERNAME_PATH}           id= username
${CTT_LOGIN_PASSWORD_PATH}           id= password
${CTT_LOGIN_SUBMIT_ELEMENT_PATH}     css= button[type='button']
${LOGGED_IN_TEXT}                    xpath=//*[text()='Logged in as']
${LOGGED_IN_VALIDATION_ERROR}   Get Text    xpath=//*[@id='loginErrorMessage']
# ${LOGGED_IN_USER_ID}    Get Text    xpath=//*[@id="root"]/div[1]/div[1]/header/div/div[2]/div/div/div/div

*** Keywords ***
Login Content Transformation Tool
    [Arguments]     ${CTT_BASE_URL}   ${USER_NAME}    ${PASSWORD}
    Open Content Transformation Tool    ${CTT_BASE_URL}
    Perform CTT Login   ${USER_NAME}    ${PASSWORD}

Perform CTT Login Validation
    [Arguments]    ${CTT_BASE_URL}    ${INVALID_USER_NAME}    ${INVALID_PASSWORD}
    Open Browser    ${CTT_BASE_URL}    ${BROWSER}
    Maximize Browser Window
    Input text    ${CTT_LOGIN_USERNAME_PATH}    ${INVALID_USER_NAME}
    Input Password    ${CTT_LOGIN_PASSWORD_PATH}    ${INVALID_PASSWORD}
    Click Button    ${CTT_LOGIN_SUBMIT_ELEMENT_PATH}
    Wait Until Element Is Visible    ${LOGGED_IN_VALIDATION_ERROR}    timeout=${LONG_WAIT}

Open Content Transformation Tool
    [Arguments]     ${CTT_BASE_URL}
    Open Browser    ${CTT_BASE_URL}   ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible   ${CTT_LOGIN_PAGE_VIEW}  timeout=${LONG_WAIT}

Perform CTT Login
    [Arguments]   ${USER_NAME}    ${PASSWORD}
    Input Text              ${CTT_LOGIN_USERNAME_PATH}       ${USER_NAME}
    Input Password          ${CTT_LOGIN_PASSWORD_PATH}       ${PASSWORD}
    Click Button            ${CTT_LOGIN_SUBMIT_ELEMENT_PATH}
    Wait Until Element Is Visible   ${LOGGED_IN_TEXT}     timeout=${LONG_WAIT}
  
