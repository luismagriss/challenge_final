*** Settings ***
Documentation        Testes de autenticação

Resource             ../../resources/base.resource


*** Test Cases ***
Cenário: Registrar um novo usuário com sucesso   
    ${new_user}        Set Variable    user_test@email.com 
    ${response}    POST Endpoint auth/register    ${new_user}
    Should Be Equal As Strings    ${response.status_code}    201
    Should Not Be Empty    ${response.json()}[data][token]
    Should Be Equal    ${response.json()}[data][role]     user
    Remove User    ${new_user}

Cenario: Tentar registrar um usuário com um e-mail já cadastrado
    ${response}    POST Endpoint auth/register    admin@example.com    expected_status=400
    Should Be Equal As Strings    ${response.status_code}    400
    Should Be Equal    ${response.json()}[success]    ${False}
    Should Be Equal    ${response.json()}[message]    User already exists

Cenário: Logar como usuário e acessar dados do usuário
    ${response}    POST Endpoint auth/login    regularuser@mail.com    teste123
    Should Be Equal As Strings    ${response.status_code}    200
    Should Not Be Empty    ${response.json()}[data][token]
    Start Session
    ${response}    GET Endpoint auth/me

Cenario: Tentativa de login com credenciais inválidas
    ${response}    POST Endpoint auth/login    testeinvalido@qa.com    teste123    expected_status=401
    Should Be Equal As Strings    ${response.status_code}    401
    Should Not Be Empty    ${response.json()}[message]    Invalid email or password
    Should Be Equal    ${response.json()}[success]    ${False}

Cenário: Tentar acessar rota de administrador como usuário comum
    ${response}           POST Endpoint auth/login    regularuser@mail.com    teste123
    Should Be Equal As Strings    ${response.status_code}    200
    Should Not Be Empty    ${response.json()}[data][token]
    
    Start Session
    ${body}    Generate random movie data
    ${response_movies}    POST Endpoint /movies    ${body}    expected_status=403
    Should Be Equal As Strings    ${response_movies.status_code}    403
    Should Be Equal    ${response_movies.json()}[message]    User role user is not authorized to access this route
    Should Be Equal    ${response_movies.json()}[success]    ${False}