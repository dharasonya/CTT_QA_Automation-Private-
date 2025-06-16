*** Settings ***
Resource    ../../page-objects/ctt_user_login/ctt_login.robot
Resource    ../../page-objects/ctt_menu_dashboard/ctt_dashboard.robot
Resource    ../../page-objects/ctt_menu_projects/ctt_tab_projects.robot
Resource    ../../tests/ctt_test_suite/ctt_env.robot
   
Resource    ../../page-objects/ctt_menu_home/ctt_tab_home.robot
  
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
CTT Project Assignment
    Go To Tab Projects
    Create Project
    Assign and Complete Project Assignment    ${CREATE_PROJECT_NAME}    ${CLIENT_DESCRIPTION}    ${PROJECT_LEAD}    ${PROJECT_GROUP}    ${DOMAIN}
    Go To Tab Home
    View Created Project    ${PROJECT_GROUP}    ${CREATE_PROJECT_NAME}