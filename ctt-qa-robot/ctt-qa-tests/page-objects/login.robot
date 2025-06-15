*** Settings ***
Library    SeleniumLibrary
Documentation    This is a page object file, all the automation implementation related to the logincls page must be done here.
Resource    ../resources/config.robot

*** Variables ***
#Native Login Element Path
${NATIVE_LOGIN_LINK_ELEMENT_PATH}       xpath= //p[normalize-space()='Pivotree Control Tower Account']

#Nativ Login Username, Password Boxes and Login submit Xpath
${NATIVE_LOGIN_USERNAME_PATH}           xpath= //input[@name='username']
${NATIVE_LOGIN_PASSWORD_PATH}           xpath= //input[@name='password']
${NATIVE_LOGIN_SUBMIT_ELEMENT_PATH}     xpath= //button[@data-test-subj='loginSubmit']


*** Keywords ***
Login Control Tower Account
    [Arguments]     ${KIBANA_URL}   ${USER_NAME}    ${PASSWORD}     ${E_XPATH_VISIBILITY_CHECK}
    Open Control Tower URL  ${KIBANA_URL}
    Select Native Login
    Perform Native Login   ${USER_NAME}    ${PASSWORD}     ${E_XPATH_VISIBILITY_CHECK}

Open Control Tower URL
    [Arguments]     ${KIBANA_URL}
    Open Browser    ${KIBANA_URL}   ${BROWSER}
    Maximize Browser Window
    Wait Until Element Is Visible   ${NATIVE_LOGIN_LINK_ELEMENT_PATH}  timeout=${LONG_WAIT}

Select Native Login
    Click Element                   ${NATIVE_LOGIN_LINK_ELEMENT_PATH}
    Wait Until Element Is Visible   ${NATIVE_LOGIN_SUBMIT_ELEMENT_PATH}      timeout=${LONG_WAIT}

Perform Native Login
    [Arguments]   ${USER_NAME}    ${PASSWORD}   ${E_XPATH_VISIBILITY_CHECK}
    Input Text              ${NATIVE_LOGIN_USERNAME_PATH}       ${USER_NAME}
    Input Password          ${NATIVE_LOGIN_PASSWORD_PATH}       ${PASSWORD}
    Click Button            ${NATIVE_LOGIN_SUBMIT_ELEMENT_PATH}
    Wait Until Element Is Visible   ${E_XPATH_VISIBILITY_CHECK}     timeout=${LONG_WAIT}
