*** Settings ***
Documentation        Cenários de testes na página de Login
Library              Browser
Resource             ../../resources/base.resource
Test Setup           Start Browser Session
Test Teardown        Close Browser
Test Tags            login    authentication

*** Test Cases ***
Cenário: Realizar uma reserva de ponta a ponta com sucesso
    ${session_id}       Set Variable    6865d643158f64ced71c6814
    ${user}             Create Dictionary
    ...                 email=${regular_user}
    ...                 password=${user_password}
    
    Go to login page
    Submit Login Form    ${user}

    ${token}    Get Jwt From Local Storage
    Should Not Be Empty    ${token}
    ${JWT_TOKEN}    Set Global Variable    ${token}
    Start Session

    Alert should be    Login realizado com sucesso!
    Click    css=.movie-info:has(h3.movie-title:text("Fight Club")) .btn.btn-primary
    # Clica no botão "Selecionar assentos" da sessão de 19h do dia 23/06/2025
    Click    css=a[href="/sessions/${session_id}"]  
    # Clica no assento escolhido
    Click    css=button[title="Fileira E, Assento 5 - Status: available"]
    Element should be    css=.selected-seats ul li >> text=Fileira E, Assento 5    Fileira E, Assento 5
    # Clica em 'Continuar para Pagamento'
    Click    css=.checkout-button
    # Clica no método de pagamento escolhido (PIX)
    Click    xpath=//div[contains(@class, "payment-method") and ./span[text()="PIX"]]
    # Clica em 'Finalizar Compra'
    Click    css=button.btn.btn-primary.btn-checkout
    Element should be    css=h1 >> text=Reserva Confirmada!    Reserva Confirmada!
    # Reseta os assentos
    Start Administrator Session
    PUT Endpoint /sessions/id/reset-seats    ${session_id}

Cenário: Login de Administrador com sucesso e validação de token
    [Tags]    E2E
    ${user}             Create Dictionary
    ...                 email=${admin_user}
    ...                 password=${user_password}
    
    Go to login page
    Submit signup form    ${user}
    Alert should be       Login realizado com sucesso!
    # Verifica se cabeçalho da página contém texto "Administração" para validar login como admin
    ${element}    Set Variable    xpath=//div[contains(@class, "header-container")]//a[text()="Administração"]
    Wait For Elements State    ${element}    visible    5
    Get Text                   ${element}    equal      Administração
    # Busca o token no Local Storage
    ${token}    Get Jwt From Local Storage
    Should Not Be Empty    ${token}
    ${BEARER_TOKEN}    Set Variable    Bearer ${token}


    ${headers}    Create Dictionary
    ...           accept=application/json
    ...           Authorization=${BEARER_TOKEN}
    ...           Content-Type=application/json

    # Tenta acessar rota exclusiva de administrador via API para validar o token obtido do Local Storage
    ${body}        Generate random movie data
    ${response}    POST    ${BASE_URL}/movies    json=${body}    headers=${headers}
    Should Be Equal As Strings    ${response.status_code}    201