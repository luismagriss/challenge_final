*** Settings ***
Documentation        Keywords utilizada no endpoint de autenticação

Resource        ../base.resource
Resource        ../data/dynamic_data.resource
Library         RequestsLibrary
Library         FakerLibrary

*** Variables ***


*** Keywords ***
POST Endpoint auth/register
    [Arguments]    ${email}    ${name}=Usuario    ${password}=teste123    ${expected_status}=${NONE}
    
    ${body}    Create Dictionary
    ...        name=${name}
    ...        email=${email}
    ...        password=${password}
    
    ${response}    POST    ${BASE_URL}/auth/register    ${body}    expected_status=${expected_status}
    RETURN    ${response}

POST Endpoint auth/login
    [Arguments]    ${email}    ${password}    ${expected_status}=${None}

    ${body}    Create Dictionary
    ...        email=${email}
    ...        password=${password}

    ${response}    POST    ${BASE_URL}/auth/login    ${body}    expected_status=${expected_status}

    Run Keyword If    ${response.status_code} == 200 and ${response.json()}[success] == ${TRUE}
    ...    Set Global Variable    ${JWT_TOKEN}    ${response.json()}[data][token]

    RETURN    ${response}

GET Endpoint auth/me
    ${response}    GET On Session    CinemaApp    /auth/me

    RETURN    ${response}

POST Endpoint /movies
    ${body}    Generate random movie data
    ${response}    POST On Session    CinemaApp    ${BASE_URL}/movies  json=${body}    expected_status=403

    RETURN    ${response}