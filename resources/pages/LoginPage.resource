*** Settings ***
Documentation        Keywords da página de login
Library              Browser
Resource             ../base.resource

*** Keywords ***
Go to login page
    Go To             http://localhost:3002/login
    #Checkpoint
    ${element}        Set Variable    css=.login-header h1 >> text=Login
    Wait For Elements State    ${element}    visible    5
    Get Text                   ${element}    equal      Login

Submit Login Form
    [Arguments]    ${user} 
    Fill Text    id=email       ${user}[email]
    Fill Text    id=password    ${user}[password]
    Click        css=.btn.btn-primary.login-btn

Notice should be
    [Arguments]    ${message}
    ${notice_element}    Set Variable    css=.alert-content
    Wait For Elements State    ${notice_element}    visible    5
    Get Text                   ${notice_element}    equal      ${message}

Alert should be
    [Arguments]    ${message}
    ${alert_element}    Set Variable    css=.alert-content

    Wait For Elements State    ${alert_element}    visible    5
    Get Text                   ${alert_element}    equal      ${message}

Element should be
    [Arguments]    ${page_element}    ${message}
    Wait For Elements State    ${page_element}    visible    5
    Get Text                   ${page_element}    equal      ${message}

