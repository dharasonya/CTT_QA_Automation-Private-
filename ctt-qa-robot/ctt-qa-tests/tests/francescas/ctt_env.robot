*** Settings ***
Documentation       This is the common settings for each customer test environment.

*** Variables ***
${USER_NAME}                    sonyadhara@gmail.com                    
${PASSWORD}                     p6uZ8zAv
${INVALID_USER_NAME}                    dummyuser@gmail.com                    
${INVALID_PASSWORD}                     dumm1239
${CTT_BASE_URL}    https://development.d36z6oo50ky8dh.amplifyapp.com/login
${KIBANA_OMS_SPACE}       oms
${KIBANA_API_KEY}     MEZVQ0Q1WUJYTmZRQ1F5V2lkLXQ6SHdXX3NmWFpSV1NWZUpvMktBV2w3dw==

${CREATE_PROJECT_NAME}    Test Project 1131
${CLIENT_DESCRIPTION}    Test Project Auto
${PROJECT_LEAD}    sonyadhara@gmail.com    
${PROJECT_GROUP}    Test Auto Suite
${DOMAIN}    TEST

&{HEADERS}
...    Authorization=ApiKey ${KIBANA_API_KEY}
...    kbn-xsrf=true
