*** Settings ***
Library    SeleniumLibrary
Documentation    This is a page object file, all the automation implementation related to the dashboard page must be done here.
Resource    ../resources/config.robot
Resource    ../page-objects/dashboard.robot
Resource    ../page-objects/validation.robot

*** Variables ***
${XPATH_VISUALIZATION_RAW}           xpath=//span[text()='Raw']
${XPATH_VISUALIZATION_FORMATTED}     xpath=//span[text()='Formatted']

*** Keywords ***
Validate Dashboard
    [Arguments]    ${NO_OF_DAYS_FILTER}    ${DASHBOARD_NAME_STRING}    ${XPATH_CT_DASHBOARD_XPATH}     ${XPATH_WHICH_DASHBOARD}
    Open Dashboard Details     ${NO_OF_DAYS_FILTER}    ${DASHBOARD_NAME_STRING}    ${XPATH_CT_DASHBOARD_XPATH}     ${XPATH_WHICH_DASHBOARD}



