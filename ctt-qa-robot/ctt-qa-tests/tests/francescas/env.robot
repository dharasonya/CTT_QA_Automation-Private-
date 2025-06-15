*** Settings ***
Documentation       This is the common settings for each customer test environment.

*** Variables ***
${USER_NAME}                    elastic_admin
${PASSWORD}                     uheU7tyR9M5j0r5N
${KIBANA_BASE_URL}    https://fran-dev-control-tower.pivotree.engineering
${KIBANA_OMS_SPACE}       oms
${KIBANA_API_KEY}     MEZVQ0Q1WUJYTmZRQ1F5V2lkLXQ6SHdXX3NmWFpSV1NWZUpvMktBV2w3dw==

&{HEADERS}
...    Authorization=ApiKey ${KIBANA_API_KEY}
...    kbn-xsrf=true
