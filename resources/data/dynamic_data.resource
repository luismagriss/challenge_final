*** Settings ***
Documentation        Dados gerados dinamicamente

Resource             ../base.resource
Library              FakerLibrary
Library              RequestsLibrary
Library              Collections

*** Keywords ***
Generate random movie data
    ${movie_title}             FakerLibrary.Sentence         nb_words=3
    ${movie_synopsis}          FakerLibrary.Text             max_nb_chars=40
    ${movie_director}          FakerLibrary.Name
    ${movie_release}           FakerLibrary.Date
    ${movie_classification}    FakerLibrary.Random Number    digits=2    fix_len=${True}
    ${movie_duration}          FakerLibrary.Random Number    digits=4

    @{movie_genres}            Create List    Ação    Comédia    Drama    Ficção Cientifica    Suspense
    ${random_genres}           Evaluate       random.choice(${movie_genres})    modules=random


    ${body}    Create Dictionary
    ...        title=${movie_title}
    ...        synopsis=${movie_synopsis}
    ...        director=${movie_director}
    ...        genres=@{movie_genres}
    ...        duration=7200
    ...        classification=${movie_classification}
    ...        poster=poster
    ...        releaseDate=${movie_release}
    
    RETURN    ${body}

Generate Dynamic Reservation Payload
    [Documentation]    Gera um corpo de requisição dinâmico para criar uma nova reserva.
    ...    Primeiro, busca os assentos de uma sessão, depois seleciona aleatoriamente
    ...    assentos disponíveis e monta o payload final.
    [Arguments]    ${session_id}
    POST Endpoint auth/login    teste@qa.com    teste123

    Start Session

    # Etapa 1: Obter o estado atual dos assentos da sessão
    ${response}    GET On Session    CinemaApp    /sessions/${session_id}
    Should Be Equal As Strings    ${response.status_code}    200

    # Extrai a lista de assentos da resposta.
    # Assumindo que a resposta JSON tem uma chave "seats" com a lista.
    ${all_seats}=    Set Variable    ${response.json()}[data][seats]

    # Filtra para obter apenas os assentos que estão ocupados
    @{occupied_seats}=    Create List
    FOR    ${seat}    IN    @{all_seats}
        Log    ${seat}
        IF    "${seat['status']}" == "occupied"
            Append To List    ${occupied_seats}    ${seat}
        END
    END

    # Etapa 2: Chamar a biblioteca Python para escolher assentos livres
    # Vamos reservar 2 assentos como padrão.
    ${selected_seats}=    Get Random Available Seats
    ...    occupied_seats_list=${occupied_seats}
    ...    seats_to_book=2

    # Etapa 3: Montar o corpo da requisição final
    @{payment_methods}=    Create List    credit_card    debit_card    pix
    ${random_payment}=     Evaluate    random.choice(${payment_methods})    modules=random

    ${body}=    Create Dictionary
    ...    session=${session_id}
    ...    seats=${selected_seats}
    ...    paymentMethod=${random_payment}

    RETURN    ${body}