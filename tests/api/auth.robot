*** Settings ***
Documentation        Testes de autenticação
Library              RequestsLibrary
Resource             ../../resources/base.resource
Suite Setup          Start Session

*** Test Cases ***

Cenário: Registrar um novo usuário com sucesso
    ${response}    POST Endpoint /register
    Should Be Equal As Strings    ${response.status_code}    201
    Log    ${response.json()}
    Should Contain     ${response.json()}[data][token]    ${PARTIAL_TOKEN}
    Should Be Equal    ${response.json()}[data][role]     user