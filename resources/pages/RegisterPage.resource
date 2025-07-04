*** Settings ***
Documentation        Keywords da página de cadastro de usuário
Library              Browser
Resource             ../base.resource

*** Keywords ***
Go to register page
    Go To             http://localhost:3002/register
    #Checkpoint
    ${element}        Set Variable    css=.register-container h1
    Wait For Elements State    ${element}    visible    5
    Get Text                   ${element}    equal      Cadastro

Submit signup form
    [Arguments]    ${user}
    Fill Text    id=name               ${user}[name]
    Fill Text    id=email              ${user}[email]
    Fill Text    id=password           ${user}[password]
    Fill Text    id=confirmPassword    ${user}[password]
    Click        css=button[type=submit]