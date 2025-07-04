*** Settings ***
Documentation        Testes de API do endpoint /movies

Resource             ../../resources/base.resource

*** Test Cases ***
Cenário: Excluir um filme existente como Administrador
    ${response}        POST Endpoint auth/login    teste@qa.com    teste123
    Start Session

    ${body}                   Generate random movie data
    ${post_movie_response}    POST Endpoint /movies        ${body}

    ${delete_movie_response}      DELETE Endpoint /movies    ${post_movie_response.json()}[data][id]
    Should Be Equal As Strings    ${delete_movie_response.status_code}    200
    Should Be Equal               ${delete_movie_response.json()}[message]    Movie removed

    ${get_movie_response}         GET Endpoint /movies/:id    ${post_movie_response.json()}[data][id]    expected_status=404
    Should Be Equal As Strings    ${get_movie_response.status_code}    404
    Should Be Equal               ${get_movie_response.json()}[message]    Movie not found

Cenário: Atualizar os detalhes de um filme existente via API
    ${movie_id}    Set Variable    6865d642158f64ced71c67bc
    ${random_body}    Generate random movie data
    
    ${body}    Create Dictionary
    ...        title=Ghost In The Shell
    ...        synopsis=O mundo, em 2029, se tornou um local altamente informatizado, a ponto dos seres humanos poderem acessar extensas redes de informações com seu ciber-cérebros. A agente cibernética Major Motoko é a líder da unidade de serviço secreto Esquadrão Shell, responsável por combater o crime. Motoko foi tão modificada que quase todo seu corpo já é robótico. De humano só teria sobrado um fantasma de si mesma.
    ...        director=${random_body}[director]
    ...        genres=Ficção Cientifica
    ...        duration=50000
    ...        classification=18
    ...        poster=string
    ...        releaseDate=1995-11-18

    ${response}    PUT Endpoint /movies/:id    ${movie_id}    ${body}
    Should Be Equal As Strings    ${response.status_code}    200
    Should Be Equal    ${response.json()}[success]    ${True}
