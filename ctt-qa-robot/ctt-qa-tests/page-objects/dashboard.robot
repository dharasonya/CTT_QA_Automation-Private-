*** Settings ***
Library    SeleniumLibrary
Documentation    This is a page object file, all the automation implementation related to the dashboard page must be done here.
Resource    ../resources/config.robot
Resource    ./menu_utils.robot

*** Variables ***
${XPATH_UNABLE_TO_LOAD_VISUALIZATION}   xpath=//h2[normalize-space()='Unable to load visualization']
${DATA_VIEW_ERROR}                      Error executing runtime field or scripted field on
${XPATH_PRETTY_FORMAT_BUTTON}      xpath=//button[@data-test-subj='superDatePickerShowDatesButton']
${XPATH_RELATIVE_START_POPOVER}   xpath=//button[@data-test-subj='superDatePickerstartDatePopoverButton']
${XPATH_REFRESH_BUTTON}    xpath=//button[@data-test-subj='querySubmitButton']
${XPATH_START_DATE_VALUE}     xpath=//label[normalize-space()='Start date']/following::input[@readonly][1]
${XPATH_DATE_UNIT_SELECTOR}   xpath=//select[@data-test-subj='superDatePickerRelativeDateInputUnitSelector']
${XPATH_DATE_NUMBER_INPUT}    xpath=//input[@data-test-subj='superDatePickerRelativeDateInputNumber']
${XPATH_UNABLE_TO_LOAD_VISUALIZATION}   xpath=//h2[normalize-space()='Unable to load visualization']
${XPATH_CT_MENU_BUTTON}               xpath=//button[@data-test-subj='toggleNavButton']
${XPATH_DASHBOARD_SIDE_MENU}          xpath=//span[text()='Dashboards']/ancestor::a
${XPATH_DASHBOARD_SEARCH}            xpath=//input[@data-test-subj='tableListSearchBox']

*** Keywords ***
Dashboard Validation
    Sleep    ${MEDIUM_WAIT}
    Element Should Not Be Visible    ${XPATH_UNABLE_TO_LOAD_VISUALIZATION}
    Fail If Runtime Script Error Exists

Open Dashboard Details
    [Arguments]    ${NO_OF_DAYS_FILTER}    ${DASHBOARD_NAME_STRING}    ${XPATH_CT_DASHBOARD_XPATH}     ${XPATH_WHICH_DASHBOARD}
    Open CT Dashboard   ${DASHBOARD_NAME_STRING}    ${XPATH_CT_DASHBOARD_XPATH}
    Click Dashboards Link   ${XPATH_WHICH_DASHBOARD}
    Set Start Date To N Days Ago    ${NO_OF_DAYS_FILTER}
    Fail If Runtime Script Error Exists

Click Dashboards in side menu
    Wait Until Element Is Visible    ${XPATH_DASHBOARD_SIDE_MENU}    timeout=${LONG_WAIT}
    Click Element                    ${XPATH_DASHBOARD_SIDE_MENU}

Search dashboard
    [Arguments]    ${DASHBOARD_NAME_STRING}
    Wait Until Element Is Visible    ${XPATH_DASHBOARD_SEARCH}    timeout=${LONG_WAIT}
    Input Text                       ${XPATH_DASHBOARD_SEARCH}    ${DASHBOARD_NAME_STRING}

Click Control Tower dashboard
    [Arguments]    ${XPATH_CT_DASHBOARD_XPATH}
    Wait Until Element Is Visible    ${XPATH_CT_DASHBOARD_XPATH}    timeout=${LONG_WAIT}
    Click Element                    ${XPATH_CT_DASHBOARD_XPATH}

Click Dashboards Link
    [Arguments]    ${XPATH_WHICH_DASHBOARD}
    Wait Until Element Is Visible    ${XPATH_WHICH_DASHBOARD}    timeout=${LONG_WAIT}
    Click Element                    ${XPATH_WHICH_DASHBOARD}

Fail If Runtime Script Error Exists
    ${error}=    Run Keyword And Return Status
    ...    Page Should Contain    ${DATA_VIEW_ERROR}
    Run Keyword If    ${error}
    ...    Fail    ❌ Runtime scripted field error found on the page!

Set Start Date To N Days Ago
    [Arguments]    ${DAYS}=14

    Open Start Date Popover

    # Input number of days
    Wait Until Element Is Visible    ${XPATH_DATE_NUMBER_INPUT}    timeout=${LONG_WAIT}
    Clear Element Text               ${XPATH_DATE_NUMBER_INPUT}
    Sleep    1s
    Input Text                       ${XPATH_DATE_NUMBER_INPUT}    ${DAYS}

    # Select unit = "Days ago"
    Wait Until Element Is Visible    ${XPATH_DATE_UNIT_SELECTOR}
    Select From List By Value        ${XPATH_DATE_UNIT_SELECTOR}    d

    # Optional: wait for start date input to reflect the change
    Wait Until Element Is Visible    ${XPATH_START_DATE_VALUE}    timeout=${LONG_WAIT}

    # Click refresh to apply date range
    Wait Until Element Is Visible    ${XPATH_REFRESH_BUTTON}    timeout=${LONG_WAIT}
    Click Element                    ${XPATH_REFRESH_BUTTON}

    # Stabilize the page
    Sleep   ${SHORT_WAIT}

Open Start Date Popover
    ${has_pretty_format}=    Run Keyword And Return Status
    ...    Wait Until Element Is Visible    ${XPATH_PRETTY_FORMAT_BUTTON}    timeout=5s

    IF    "${has_pretty_format}" == "True"
        Click Element    ${XPATH_PRETTY_FORMAT_BUTTON}
    ELSE
        Click Element    ${XPATH_RELATIVE_START_POPOVER}
    END

Open CT Dashboard
    [Arguments]     ${DASHBOARD_NAME_STRING}    ${XPATH_CT_DASHBOARD_XPATH}
    Click CT main menu toggle
    Click Dashboards in side menu
    Search dashboard    ${DASHBOARD_NAME_STRING}
    Click Control Tower dashboard  ${XPATH_CT_DASHBOARD_XPATH}




