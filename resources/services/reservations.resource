*** Settings ***
Documentation        Keywords utilizada no endpoint /movies

Resource             ../base.resource

*** Keywords ***
POST Endpoint /reservations
    [Arguments]    ${body}    ${expected_status}=${None}
    ${response}    POST On Session    CinemaApp    /reservations    json=${body}    expected_status=${expected_status}

    RETURN    ${response}

GET Endpoint /reservations/me
    [Arguments]    ${expected_status}=${None}
    ${response}    GET On Session    CinemaApp    /reservations/me    expected_status=${expected_status}

    RETURN    ${response}