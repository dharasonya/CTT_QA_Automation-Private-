*** Settings ***
Resource    ../../page-objects/dev_tools.robot
Resource    ../../utils/utils.robot
Resource    ../../utils/ml_jobs_utils.robot
Resource    ../psychobunny/env.robot
Test Teardown    Close Browser
Test Setup  Login and Space Selection Proxy


*** Variables ***
${CSV_PATH_ML_JOB}     ./tests/psychobunny/ml_jobs.csv
${SPACE_PATH}               //a[normalize-space()='pb']
${POST_VALIDATION_XPATH}        //div[@data-test-subj='space-avatar-pb' and @title='pb']
${DATA_VIEW_CSV_INPUT}          ./tests/francescas/data_view_names.csv

*** Keywords ***
Login and Space Selection Proxy
    Login and Space Selection   ${KIBANA_BASE_URL}   ${USER_NAME}    ${PASSWORD}     ${SPACE_PATH}   ${POST_VALIDATION_XPATH}

*** Test Cases ***
Verify ML Jobs Health from CSV
    Click CT main menu toggle
    Click Dev Tools
    Loop And Validate ML Jobs From CSV  ${CSV_PATH_ML_JOB}