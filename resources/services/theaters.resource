*** Settings ***
Documentation        Keywords utilizada no endpoint /theaters

Resource             ../base.resource

*** Keywords ***
POST Endpoint /theaters
    [Arguments]    ${body}    ${expected_status}=${None}
    ${response}    POST On Session    CinemaApp    /theaters    json=${body}    expected_status=${expected_status}

    RETURN    ${response}

DELETE Endpoint /theaters
    [Arguments]    ${theater_id}    ${expected_status}=${None}
    ${response}    DELETE On Session    CinemaApp    /theaters/${theater_id}    expected_status=${expected_status}

    RETURN    ${response}