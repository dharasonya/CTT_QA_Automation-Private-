*** Settings ***
Resource    ../../page-objects/ctt_login.robot
Resource    ../../page-objects/space_selector.robot
Resource    ../../page-objects/ctt_dashboard.robot
Resource    ../../page-objects/ctt_tab_projects.robot
Resource    ../../page-objects/dashboard_wrapper.robot
Resource    ../../api/kibana_api.robot
Resource    ../../utils/utils.robot
Resource    ../francescas/ctt_env.robot
Resource    ../../page-objects/menu_utils.robot
Resource    ../../page-objects/xpath_constants.robot
Resource    ../../page-objects/discover_dataview.robot
Resource    ../../page-objects/ctt_tab_home.robot

Test Setup  Test CTT Login

# *** Variables ***

*** Keywords ***
Test CTT Login
    Login Content Transformation Tool    ${CTT_BASE_URL}   ${USER_NAME}    ${PASSWORD}    

*** Test Cases ***
CTT Project Assignment
    Go To Tab Projects
    Create Project
    Assign and Complete Project Assignment    ${CREATE_PROJECT_NAME}    ${CLIENT_DESCRIPTION}    ${PROJECT_LEAD}    ${PROJECT_GROUP}    ${DOMAIN}
    Go To Tab Home
    View Created Project    ${PROJECT_GROUP}    ${CREATE_PROJECT_NAME}