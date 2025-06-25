*** Settings ***
Documentation        Keywords de uso geral da automação

Resource        env.resource
Resource        services/auth.resource
Library         RequestsLibrary

*** Variables ***
${VALID_NAME}        Novo Usuário Teste
${VALID_PASSWORD}    SenhaSegura123!    

*** Keywords ***
Start Session
    ${headers}    Create Dictionary
    ...           accept=application/json
    ...           Authorization=${JWT_TOKEN}
    ...           Content-Type=application/json
    Create Session    CinemaApp    ${BASE_URL}    ${headers}