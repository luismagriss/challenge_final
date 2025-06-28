*** Settings ***
Documentation        Keywords utilizada no endpoint /users

Resource             ../base.resource

*** Keywords ***
POST Endpoint /users
    [Arguments]    ${body}    ${expected_status}=${None}
    ${response}    POST On Session    CinemaApp    users    json=${body}    expected_status=${expected_status}

    RETURN    ${response}