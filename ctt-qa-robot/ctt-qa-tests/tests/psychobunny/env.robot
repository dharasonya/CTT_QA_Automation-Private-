*** Settings ***
Documentation       This is the common settings for each customer test environment.

*** Variables ***
${USER_NAME}                    elastic
${PASSWORD}                     YWB8TLJuwzz6w0aU4iDO
${KIBANA_BASE_URL}    https://dev.pivotreecontroltower.com/
${KIBANA_PB_SPACE}       pb
${KIBANA_API_KEY}     SFRscU9aWUJvaS1XaWgxMTFlR2M6aFkzOVFLYS1SdXVuYktaN2hhMFB0UQ==

&{HEADERS}
...    Authorization=ApiKey ${KIBANA_API_KEY}
...    kbn-xsrf=true
