*** Settings ***
Documentation        Testes de autenticação
Library              RequestsLibrary
Resource             ../../resources/base.resource
Suite Setup          Start Session

*** Test Cases ***

Cenário: Registrar um novo usuário com sucesso   
    ${RANDOM_EMAIL}        FakerLibrary.Email 
    ${response}    POST Endpoint /register    ${RANDOM_EMAIL}
    Should Be Equal As Strings    ${response.status_code}    201
    Should Contain     ${response.json()}[data][token]    ${PARTIAL_TOKEN}
    Should Be Equal    ${response.json()}[data][role]     user

Cenario: Tentar registrar com email duplicado
    ${response}    POST Endpoint /register    admin@example.com    expected_status=400
    Should Be Equal As Strings    ${response.status_code}    400
    Should Be Equal    ${response.json()}[success]    ${False}
    Should Be Equal    ${response.json()}[message]    User already exists


