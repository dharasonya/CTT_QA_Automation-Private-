*** Settings ***
Resource    ../../page-objects/ctt_login.robot
Resource    ../../page-objects/space_selector.robot
Resource    ../../page-objects/ctt_dashboard.robot
Resource    ../../page-objects/dashboard_wrapper.robot
Resource    ../../api/kibana_api.robot
Resource    ../../utils/utils.robot
Resource    ../francescas/ctt_env.robot
Resource    ../../page-objects/menu_utils.robot
Resource    ../../page-objects/xpath_constants.robot
Resource    ../../page-objects/discover_dataview.robot

Test Teardown    Close Browser
Test Setup  Test CTT Login

# *** Variables ***

*** Keywords ***
Test CTT Login
    Login Content Transformation Tool    ${CTT_BASE_URL}   ${USER_NAME}    ${PASSWORD}    

*** Test Cases ***
CTT Dashboard Validation
    CTT Dashboard Visualization    ${USER_NAME}
