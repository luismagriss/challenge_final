*** Settings ***
Documentation        Keywords utilizada no endpoint /sessions

Resource             ../base.resource

*** Keywords ***
POST Endpoint /sessions
    [Arguments]    ${body}    ${expected_status}=${None}
    ${response}    POST On Session    CinemaApp    /sessions    json=${body}    expected_status=${expected_status}

    RETURN    ${response}