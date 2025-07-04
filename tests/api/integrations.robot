*** Settings ***
Documentation        Testes de API integrando diferentes endpoints

Resource             ../../resources/base.resource

*** Test Cases ***
Cenário: Fluxo completo de cadastro de filme, sala e sessão de forma integrada
    Start Administrator Session
    
    ${movie_body}        Get Valid Movie Payload
    ${theater_body}      Get Valid Theater Body

    ${movie_response}      POST Endpoint /movies      ${movie_body}
    ${theater_response}    POST Endpoint /theaters    ${theater_body}

    ${session_body}    Create Dictionary
    ...        movie=${movie_response.json()}[data][_id]
    ...        theater=${theater_response.json()}[data][_id]
    ...        datetime=2025-06-28T00:56:21.160Z
    ...        fullPrice=20
    ...        halfPrice=10

    ${session_response}    POST Endpoint /sessions    ${session_body}

    [Teardown]    Clear Test Data    ${movie_response.json()}[data][_id]    ${theater_response.json()}[data][id]    ${session_response.json()}[data][id]