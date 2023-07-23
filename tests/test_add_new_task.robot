*** Settings ***
Documentation   Automated tests for Todo List website
Library          SeleniumLibrary
Suite Setup      Open Browser  ${URL}  ${BROWSER}
Suite Teardown   Close Browser

*** Variables ***
${URL}           https://abhigyank.github.io/To-Do-List/
${BROWSER}       chrome

*** Test Cases ***
Add New Task
    [Documentation]  Add a new task and verify it appears in the task list.
    Input Text        id:new-task    New Task Example
    Click Element     id:add-task-btn
    Element Should Be Visible    xpath://ul[@id='todo-list']//li[contains(text(), 'New Task Example')]

Complete Task
    [Documentation]  Add a new task and mark it as completed.
    Input Text        id:new-task    New Task to be Completed
    Click Element     id:add-task-btn
    Click Element     xpath://ul[@id='todo-list']//li[contains(text(), 'New Task to be Completed')]/input[@type='checkbox']
    Element Should Have Attribute  xpath://ul[@id='todo-list']//li[contains(text(), 'New Task to be Completed')]/input[@type='checkbox']  checked

Delete Task
    [Documentation]  Add a new task and then delete it.
    Input Text        id:new-task    Task to be Deleted
    Click Element     id:add-task-btn
    Click Element     xpath://ul[@id='todo-list']//li[contains(text(), 'Task to be Deleted')]/button
    Element Should Not Be Visible  xpath://ul[@id='todo-list']//li[contains(text(), 'Task to be Deleted')]

*** Keywords ***
Open Browser
    [Arguments]    ${url}    ${browser}
    Open Browser    ${url}    ${browser}
    Maximize Browser Window

Close Browser
    Close All Browsers