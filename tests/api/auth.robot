*** Settings ***
Documentation        Testes de autenticação
Library              RequestsLibrary
Resource             ../../resources/base.resource


*** Test Cases ***

Cenário: Registrar um novo usuário com sucesso   
    ${RANDOM_EMAIL}        FakerLibrary.Email 
    ${response}    POST Endpoint auth/register    ${RANDOM_EMAIL}
    Should Be Equal As Strings    ${response.status_code}    201
    Should Not Be Empty    ${response.json()}[data][token]
    Should Be Equal    ${response.json()}[data][role]     user

Cenario: Tentar registrar com email duplicado
    ${response}    POST Endpoint auth/register    admin@example.com    expected_status=400
    Should Be Equal As Strings    ${response.status_code}    400
    Should Be Equal    ${response.json()}[success]    ${False}
    Should Be Equal    ${response.json()}[message]    User already exists

Cenário: Logar como usuário e acessar dados do usuário
    ${response}    POST Endpoint auth/login    teste@qa.com    teste123
    Should Be Equal As Strings    ${response.status_code}    200
    Should Not Be Empty    ${response.json()}[data][token]
    Start Session
    ${response}    GET Endpoint auth/me

Cenário: Tentar acessar rota de administrador como usuário comum
    ${response}           POST Endpoint auth/login    regularuser@mail.com    teste123
    Should Be Equal As Strings    ${response.status_code}    200
    Should Not Be Empty    ${response.json()}[data][token]
    Start Session
    ${response_movies}    POST Endpoint /movies
    Should Be Equal As Strings    ${response_movies.status_code}    403
    Should Be Equal    ${response_movies.json()}[message]    User role user is not authorized to access this route
    Should Be Equal    ${response_movies.json()}[success]    ${False}