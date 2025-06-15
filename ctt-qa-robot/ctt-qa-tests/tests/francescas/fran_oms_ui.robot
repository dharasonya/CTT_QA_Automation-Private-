*** Settings ***
Resource    ../../page-objects/login.robot
Resource    ../../page-objects/space_selector.robot
Resource    ../../page-objects/dashboard.robot
Resource    ../../page-objects/dashboard_wrapper.robot
Resource    ../../api/kibana_api.robot
Resource    ../../utils/utils.robot
Resource    ../francescas/env.robot
Resource    ../../page-objects/menu_utils.robot
Resource    ../../page-objects/xpath_constants.robot
Resource    ../../page-objects/discover_dataview.robot

Test Teardown    Close Browser
Test Setup  Test setup Login and Space Selection

*** Variables ***
${OMS_SPACE_PATH}               //a[normalize-space()='Fluent OMS']
${POST_VALIDATION_XPATH}        //div[@data-test-subj='space-avatar-oms' and @title='Fluent OMS']
${DATA_VIEW_CSV_INPUT}          ./tests/francescas/data_view_names.csv


*** Keywords ***
Test setup Login and Space Selection
    Login Control Tower Account    ${KIBANA_BASE_URL}   ${USER_NAME}    ${PASSWORD}     ${OMS_SPACE_PATH}
    Select Your Space   ${OMS_SPACE_PATH}   ${POST_VALIDATION_XPATH}

*** Test Cases ***
OMS Space Dashboard Visualization
    Dashboard Validation

Orders Details Dashboard Validation
    Validate Dashboard     14   ${CT_HOME_STRING}  ${XPATH_CT_HOME_DASHBOARD_XPATH}   ${XPATH_ORDER_DASHBOARD}
    Validate elements are visible   ${XPATH_VISUALIZATION_RAW}
    Validate elements are visible   ${XPATH_VISUALIZATION_FORMATTED}

Fulfillment Dashboard Validation
    Validate Dashboard     14   ${CT_HOME_STRING}  ${XPATH_CT_HOME_DASHBOARD_XPATH}  ${XPATH_FULFILLMENT_DASHBOARD}
    Validate elements are visible   ${XPATH_VISUALIZATION_RAW}
    Validate elements are visible   ${XPATH_VISUALIZATION_FORMATTED}

Dataview validation on discovery
    Click CT main menu toggle
    Click menu in side menu option      ${XPATH_DISCOVER_SIDE_MENU}
    Validate elements are visible       ${XPATH_DATA_VIEW_HEADER}
    Search Dataview for CSV Input       ${DATA_VIEW_CSV_INPUT}




