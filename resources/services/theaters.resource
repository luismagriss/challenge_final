*** Settings ***
Documentation        Keywords utilizada no endpoint /theaters

Resource             ../base.resource

*** Keywords ***
POST Endpoint /theaters
    [Arguments]    ${body}    ${expected_status}=${None}
    ${response}    POST On Session    CinemaApp    /theaters    json=${body}    expected_status=${expected_status}

    RETURN    ${response}