*** Settings ***
Documentation        Keywords de uso geral da automação

Resource        env.resource
Resource        ../data/dynamic_data.resource
Resource        ../fixtures/sessions_fixtures.resource
Resource        ../fixtures/movies_fixtures.resource
Resource        ../fixtures/users_fixtures.resource
Resource        ../fixtures/theaters_fixtures.resource
Resource        ../fixtures/reservations_fixtures.resource
Resource        services/auth.resource
Resource        services/movies.resource
Resource        services/sessions.resource
Resource        services/reservations.resource
Resource        services/theaters.resource
Resource        services/users.resource
Library         ../libraries/reservations_utils.py
Library         RequestsLibrary
Library         FakerLibrary


*** Variables ***
${VALID_NAME}        Novo Usuário Teste
${VALID_PASSWORD}    SenhaSegura123!    

*** Keywords ***
Start Session
    ${BEARER_TOKEN}    Set Variable    Bearer ${JWT_TOKEN}
    ${headers}    Create Dictionary
    ...           accept=application/json
    ...           Authorization=${BEARER_TOKEN}
    ...           Content-Type=application/json
    Create Session    CinemaApp    ${BASE_URL}    ${headers}

Start User Session
    POST Endpoint auth/login    ${regular_user}    ${user_password}
    Start Session

Start Administrator Session
    POST Endpoint auth/login    ${admin_user}    ${user_password}
    Start Session

Clear Test Data
    [Arguments]    ${movie_id}    ${theather_id}    ${session_id}
    DELETE Endpoint /movies      ${movie_id}
    DELETE Endpoint /theaters    ${theather_id}
    DELETE Endpoint /sessions    ${session_id}