*** Settings ***
Library    SeleniumLibrary
Documentation    All validation keywords are done here.
Resource    ../resources/config.robot



*** Keywords ***
Validate elements are visible
    [Arguments]    ${XPATH_OF_ELEMENT_CHECK}
    Wait Until Page Contains Element    ${XPATH_OF_ELEMENT_CHECK}    timeout=${LONG_WAIT}

