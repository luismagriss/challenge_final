*** Settings ***
Documentation        Keywords utilizada no endpoint de autenticação

Resource        ../base.resource
Library         RequestsLibrary
Library         FakerLibrary

*** Variables ***


*** Keywords ***
Login Admin
    ${body}    Create Dictionary
    ...        email=teste@qa.com
    ...        password=teste123

    POST    ${BASE_URL}/auth/login    ${body}

POST Endpoint /register
    [Arguments]    ${email}    ${name}=Usuario    ${password}=teste123    ${expected_status}=${NONE}
    
    ${body}    Create Dictionary
    ...        name=${name}
    ...        email=${email}
    ...        password=${password}
    
    ${response}    POST    ${BASE_URL}/auth/register    ${body}    expected_status=${expected_status}
    RETURN    ${response}