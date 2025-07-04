*** Settings ***
Documentation        Keywords utilizada no endpoint /sessions

Resource             ../base.resource

*** Keywords ***
POST Endpoint /sessions
    [Arguments]    ${body}    ${expected_status}=${None}
    ${response}    POST On Session    CinemaApp    /sessions    json=${body}    expected_status=${expected_status}

    RETURN    ${response}

DELETE Endpoint /sessions
    [Arguments]    ${session_id}    ${expected_status}=${None}
    ${response}    DELETE On Session    CinemaApp    /sessions/${session_id}    expected_status=${expected_status}

    RETURN    ${response}

PUT Endpoint /sessions/id/reset-seats
    [Arguments]    ${session_id}    ${expected_status}=${None}
    ${response}    PUT On Session    CinemaApp    /sessions/${session_id}/reset-seats    expected_status=${expected_status}

    RETURN    ${response}