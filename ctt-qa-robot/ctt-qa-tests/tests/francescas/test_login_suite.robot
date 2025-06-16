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

*** Variables ***
${ENV_URL}    https://development.d36z6oo50ky8dh.amplifyapp.com/login
${USERNAME}    default_user  # Provide a temporary value from the test file
${PASSWORD}    default_pass  # Provide a temporary value from the test file

*** Keywords ***
Test CTT Login
    Log    "Test Start"
    Log    "Received URL: ${ENV_URL}"
    Log    "Received Username: ${USERNAME}"
    Log    "Received Password: ${PASSWORD}"
    Login Content Transformation Tool    ${ENV_URL}   ${USERNAME}    ${PASSWORD}    

*** Test Cases ***
CTT Dashboard Validation
    Log    "Test Start-CASE 1"
    Log    "Received Environment URL: ${ENV_URL}"
    Log    "Received Username: ${USERNAME}"
    Log    "Received Password: ${PASSWORD}"