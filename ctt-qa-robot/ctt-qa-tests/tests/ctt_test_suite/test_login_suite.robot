*** Settings ***
Resource    ../../page-objects/ctt_user_login/ctt_login.robot
Resource    ../../page-objects/ctt_menu_dashboard/ctt_dashboard.robot
Resource    ../../tests/ctt_test_suite/ctt_env.robot
   
Test Teardown    Close Browser
Test Setup  Test CTT Login

*** Variables ***
${ENV_URL}    https://development.d36z6oo50ky8dh.amplifyapp.com/login
${USERNAME}    default_user  # Provide a temporary value from the test file
${PASSWORD}    default_pass  # Provide a temporary value from the test file
${BROWSER}    ${EMPTY}   

*** Keywords ***
Test CTT Login
    Login Content Transformation Tool    ${ENV_URL}   ${USERNAME}    ${PASSWORD}    ${BROWSER}

*** Test Cases ***
CTT Dashboard Validation
    CTT Dashboard Visualization    ${USERNAME}