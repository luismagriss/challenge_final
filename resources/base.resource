*** Settings ***
Documentation        Keywords de uso geral da automação

Resource        env.resource
Resource        data/dynamic_data.resource
Resource        data/fixtures.resource
Resource        services/auth.resource
Resource        services/movies.resource
Resource        services/sessions.resource
Resource        services/reservations.resource
Resource        services/theaters.resource
Resource        services/users.resource
Library         RequestsLibrary
Library         FakerLibrary
Library         ../libraries/ReservationUtils.py

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