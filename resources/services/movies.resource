*** Settings ***
Documentation        Keywords utilizada no endpoint /movies

Resource             ../base.resource

*** Keywords ***
POST Endpoint /movies
    [Arguments]    ${body}    ${expected_status}=${None}
    ${response}    POST On Session    CinemaApp    ${BASE_URL}/movies  json=${body}    expected_status=${expected_status}

    RETURN    ${response}

DELETE Endpoint /movies
    [Arguments]    ${movie_id}
    ${response}    DELETE On Session    CinemaApp    ${BASE_URL}/movies/${movie_id}

    RETURN    ${response}

GET Endpoint /movies/:id
    [Arguments]    ${movie_id}    ${expected_status}=${None}
    ${response}    GET On Session    CinemaApp    ${BASE_URL}/movies/${movie_id}    expected_status=${expected_status}

    RETURN    ${response}
PUT Endpoint /movies/:id
    [Arguments]    ${movie_id}    ${body}    ${expected_status}=${None}
    ${response}    PUT On Session    CinemaApp    ${BASE_URL}/movies/${movie_id}    json=${body}    expected_status=${expected_status}

    RETURN    ${response}