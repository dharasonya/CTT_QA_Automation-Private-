*** Settings ***
Library    SeleniumLibrary
Documentation    This is a page object file, all the automation implementation related to the space slection page must be done here.
Resource    ../resources/config.robot

*** Keywords ***
Select Your Space
    [Arguments]    ${SPACE_XPATH}   ${POST_VALIDATION_XPATH}
    Wait Until Element Is Visible    ${SPACE_XPATH}    timeout=${MEDIUM_WAIT}
    Click Element                    ${SPACE_XPATH}
    Wait Until Element Is Visible    ${POST_VALIDATION_XPATH}
