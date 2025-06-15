*** Settings ***
Library    SeleniumLibrary
Documentation    This is a page object file, all the automation implementation related to the menu utils must be done here.
Resource    ../resources/config.robot

*** Variables ***
${XPATH_DASHBOARD_SIDE_MENU}          xpath=//span[text()='Dashboards']/ancestor::a
${XPATH_CT_MENU_BUTTON}               xpath=//button[@data-test-subj='toggleNavButton']

*** Keywords ***
Click menu in side menu option
    [Arguments]     ${XPATH_MENU_SELECTION}
    Wait Until Element Is Visible    ${XPATH_MENU_SELECTION}    timeout=${LONG_WAIT}
    Click Element   ${XPATH_MENU_SELECTION}

Click CT main menu toggle
    Wait Until Element Is Visible    ${XPATH_CT_MENU_BUTTON}    timeout=${LONG_WAIT}
    Click Element                    ${XPATH_CT_MENU_BUTTON}