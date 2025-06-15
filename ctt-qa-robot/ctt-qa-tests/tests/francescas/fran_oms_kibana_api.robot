*** Settings ***
Resource    ../../api/kibana_api.robot
Resource    ../../utils/utils.robot
Resource    ../francescas/env.robot


*** Variables ***
${ORDER_DASHBOARD_ID}   d216281b-c551-5fa1-be6b-956b877d5b40
${ORDER_VIZ_CSV_PATH}    ./tests/francescas/visualizations_order_list.csv
${FULFILLMENT_VIZ_CSV_PATH}    ./tests/francescas/visualizations_fulfillment_list.csv
${RETURN_ORDER_VIZ_CSV_PATH}    ./tests/francescas/visualizations_return_orders_list.csv
${CSV_HDR_VIZ_TITLE}    Visualization_Title
${FULFILLMENT_DASHBOARD_ID}   bfffb4b1-8837-5cc1-8d8c-ac8dee3eef63
${RETURN_ORDERS_DASHBOARD_ID}   ec677100-e4f9-594c-90bc-6c54c5c80fd6
${ALERTS_RULES_CSV_PATH}    ./tests/francescas/alert_rules.csv
${CSV_HDR_RULE_NAME}    RuleName

*** Test Cases ***
Order Dashboard Visualization Check
    ${actual_titles}=    Fetch All Visualizations In Dashboard      ${KIBANA_BASE_URL}      ${KIBANA_OMS_SPACE}     ${HEADERS}      ${ORDER_DASHBOARD_ID}
    ${expected_titles}=  Get Data From CSV  ${ORDER_VIZ_CSV_PATH}   ${CSV_HDR_VIZ_TITLE}
    Validate All Expected Visualizations Present    ${expected_titles}  ${actual_titles}

Fulfillment Dashboard Visualization Check
    ${actual_titles}=    Fetch All Visualizations In Dashboard      ${KIBANA_BASE_URL}      ${KIBANA_OMS_SPACE}     ${HEADERS}      ${FULFILLMENT_DASHBOARD_ID}
    ${expected_titles}=  Get Data From CSV  ${FULFILLMENT_VIZ_CSV_PATH}   ${CSV_HDR_VIZ_TITLE}
    Validate All Expected Visualizations Present    ${expected_titles}  ${actual_titles}

ReturnOrders Dashboard Visualization Check
    ${actual_titles}=    Fetch All Visualizations In Dashboard      ${KIBANA_BASE_URL}      ${KIBANA_OMS_SPACE}     ${HEADERS}      ${RETURN_ORDERS_DASHBOARD_ID}
    ${expected_titles}=  Get Data From CSV  ${RETURN_ORDER_VIZ_CSV_PATH}   ${CSV_HDR_VIZ_TITLE}
    Validate All Expected Visualizations Present    ${expected_titles}  ${actual_titles}


Validate Alert Rule Is Enabled And Succeeded
    Validate Alert Rules From CSV      ${ALERTS_RULES_CSV_PATH}  ${KIBANA_BASE_URL}      ${KIBANA_OMS_SPACE}     ${HEADERS}     ${CSV_HDR_RULE_NAME}    50

Validate Dataview from Discover
    Validate Data View Has Documents    ${KIBANA_BASE_URL}      ${KIBANA_OMS_SPACE}     ${HEADERS}     fluent-exception-*    1