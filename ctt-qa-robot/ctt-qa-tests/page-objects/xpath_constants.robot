*** Settings ***
Documentation    This file should be used on xpath constansts across tests and base impl.

*** Variables ***
${CT_HOME_STRING}                    Control Tower Home
${XPATH_CT_HOME_DASHBOARD_XPATH}           xpath=//a[@data-test-subj='dashboardListingTitleLink-Control-Tower-Home']
${XPATH_ORDER_DASHBOARD}            xpath=//a[@title='Go to Order Dashboard']
${XPATH_FULFILLMENT_DASHBOARD}        xpath=//a[@title='Go to Fulfilment Dashboard']
${XPATH_DISCOVER_SIDE_MENU}          xpath=//span[text()='Discover']/ancestor::a
${XPATH_DATA_VIEW_HEADER}           //div[normalize-space(text())='Data view']
${XPATH_DATAVIEW_DROPDOWN}          (//div[normalize-space(text())='Data view']/following::button)[1]
${XPATH_DATAVIEW_INPUT_TEXT}        //input[@data-test-subj='indexPattern-switcher--input']
${XPATH_DATE_QUICK_SELECTOR}        xpath=//button[@title='Date quick select']
${XPATH_VAL_NO_RESULTS_MATCH}       xpath=//div[contains(text(), 'No results match')]
${XPATH_VAL_RUNTIME_FIELD}          xpath=//*[contains(text(), 'runtime field')]
${XPATH_VAL_UNABLE_TO_LOAD_VIZ}      xpath=//h2[normalize-space()='Unable to load visualization'

