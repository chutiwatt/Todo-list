*** Settings ***
Library           SeleniumLibrary

Suite Setup       Open Browser    ${URL}    ${BROWSER}
Suite Teardown    Close Browser

*** Variables ***
${URL}            https://abhigyank.github.io/To-Do-List/
${BROWSER}        chrome

*** Test Cases ***
Verify Todo List Functionality
    [Documentation]    Tests the basic functionality of the Todo List website
    Open Todo List
    Add Tasks    Task 1    Task 2
    Switch To Tab    To-Do Tasks
    Complete Task    Task 1
    Delete Task    Task 2
    Sleep    1s
    Switch To Tab    Completed
    Delete Completed Task    Task 1

*** Keywords ***
Open Todo List
    Open Browser    ${URL}    ${BROWSER}

Add Tasks
    [Arguments]    @{tasks}
    FOR    ${task}    IN    @{tasks}
        Input Text    css:#new-task    ${task}
        Click Element    css:button.mdl-button--fab
    END

Switch To Tab
    [Arguments]    ${tab_name}
    Click Element    xpath://a[text()="${tab_name}"]

Complete Task
    [Arguments]    ${task_name}
    Click Element    xpath://span[@class="mdl-checkbox__label" and text()="${task_name}"]
    Sleep    1s   # Add a small delay after completing the task

Delete Task
    [Arguments]    ${task_name}
    Click Element    xpath://span[text()="${task_name}"]/parent::label/following-sibling::button[contains(@class, "delete")]
    Sleep    1s   # Add a small delay after completing the task


Delete Completed Task
    [Arguments]    ${task_name}
    Sleep    1s   # Add a small delay after completing the task
    ${button_js}    Set Variable    document.querySelector('div#completed button.delete span.mdl-button__ripple-container span.mdl-ripple').click()
    Execute JavaScript    ${button_js}
    Sleep    1s   # Add a small delay after completing the task


