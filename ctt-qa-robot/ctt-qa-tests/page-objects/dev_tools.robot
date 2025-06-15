*** Settings ***
Library    SeleniumLibrary
Documentation    This is a page object file, all the automation implementation related to the discover dataview page must be done here.Dataview should not have multiple values in the drop down for the given input text.
Resource    ../resources/config.robot
Resource    ./xpath_constants.robot
Resource    ../utils/string_constants.robot
Resource    ./dashboard.robot
Library    OperatingSystem
Library    BuiltIn
Library    Collections
Library    String

*** Keywords ***
Click Dev Tools
    Wait Until Element Is Visible    xpath=//span[normalize-space()='Dev Tools']/ancestor::a    timeout=5s
    Click Element    xpath=//span[normalize-space()='Dev Tools']/ancestor::a

Execute Dev Tools Query And Get Output
    [Arguments]    ${COMMAND}

    # 1. Click on the Ace Editor's content area to focus it
    Wait Until Element Is Visible    xpath=(//div[contains(@class,'ace_content')])[1]    timeout=5s
    Click Element    xpath=(//div[contains(@class,'ace_content')])[1]
    Sleep    .5s
    Execute JavaScript    var editor = document.querySelector('.ace_editor')?.env?.editor; if (editor) editor.setValue('');

    Sleep    .5s
    Execute JavaScript    var editor = document.querySelector('.ace_editor')?.env?.editor; if (editor) editor.setValue(`${COMMAND}`);

    # Click "Run" button
    Sleep    .5s
    Wait Until Element Is Visible    xpath=//button[@aria-label='Click to send request']    timeout=5s
    Click Element    xpath=//button[@aria-label='Click to send request']

    # 5. Wait for response
    Sleep    .5s
    ${output_text}=    Execute JavaScript    return document.querySelectorAll('.ace_editor')[1]?.env?.editor?.getValue() || '';
    Log    ✅ Output from Dev Tools console: ${output_text}
    RETURN    ${output_text}

