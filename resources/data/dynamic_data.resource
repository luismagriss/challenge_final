*** Settings ***
Documentation        Dados gerados dinamicamente
Library        FakerLibrary
Library        Collections

*** Keywords ***
Generate random movie data
    ${movie_title}             FakerLibrary.Sentence    nb_words=3
    ${movie_synopsis}          FakerLibrary.Text    max_nb_chars=40
    ${movie_director}          FakerLibrary.Name
    @{movie_genres}    Create List    Ação    Comédia    Drama    Ficção Cientifica    Suspense
    ${random_genres}    Evaluate    random.choice(${movie_genres})    modules=random
    ${movie_release}           FakerLibrary.Date
    ${movie_classification}    FakerLibrary.Random Number    digits=2    fix_len=${True}
    ${movie_duration}          FakerLibrary.Random Number    digits=4

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