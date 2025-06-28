*** Settings ***
Documentation        Testes de API do endpoint /reservations

Resource             ../../resources/base.resource
Suite Setup           Start User Session

*** Test Cases ***
Cenário: Realizar uma reserva com sucesso
    ${body}    Generate Dynamic Reservation Payload    6859beb409b430d4e6e3e693
    POST Endpoint /reservations    ${body}

Cenário: Tentar reservar um assento já ocupado
    ${body}    Create Dictionary
    ...        session=${session_id}
    ...        seats=${occupied_seat}
    ...        paymentMethod=credit_card

    ${response}    POST Endpoint /reservations    ${body}    expected_status=400
    Should Be Equal As Strings    ${response.status_code}    400
    Should Be Equal               ${response.json()}[success]    ${False}

Cenário: Visualizar histórico de reservas
    POST Endpoint auth/login    ${regular_user}    ${user_password}
    ${response}    GET Endpoint /reservations/me
    Should Be Equal As Strings    ${response.status_code}    200
    Should Be Equal               ${response.json()}[success]    ${True}