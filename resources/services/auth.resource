*** Settings ***
Documentation        Keywords utilizada no endpoint de autenticação

Resource        ../base.resource

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

Obter Token do localStorage
    Wait Until Keyword Succeeds    5s    1s    Token Should Exist In LocalStorage
    ${token}    Evaluate JavaScript    ${None}    (key) => window.localStorage.getItem(key)    argument=Bearer

    RETURN    ${token}

Token Should Exist In LocalStorage
    [Documentation]    Helper keyword that fails if the token is not yet in localStorage.
    ${token}=    Evaluate Javascript    ${None}    (key) => window.localStorage.getItem(key)    argument=Bearer
    Should Not Be Empty    ${token}    Token not found in localStorage yet.