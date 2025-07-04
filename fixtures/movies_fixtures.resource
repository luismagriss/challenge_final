*** Settings ***
Documentation     Este arquivo contém keywords e dados de fixture relacionados a filmes.
...               As fixtures incluem dados válidos e inválidos para testes de criação, listagem e edição de filmes.
...               Pode ser usado em testes de API para validar comportamento com diferentes configurações de filmes.
...               Deve ser importado em testes que envolvam operações com a entidade "filme".

*** Variables ***
@{MOVIE_GENRES}     Ação    Ficção    Thriller    Guerra

*** Keywords ***
Get Valid Movie Payload
    ${movie}=    Create Dictionary
    ...    title=Platoon
    ...    synopsis=Um jovem soldado enfrenta o caos moral e psicológico da Guerra do Vietnã enquanto é dilacerado entre dois sargentos com visões opostas de guerra e humanidade.
    ...    director=Oliver Stone
    ...    genres=@{MOVIE_GENRES}
    ...    duration=7200
    ...    classification=18
    ...    poster=poster
    ...    releaseDate=2010-07-16
    RETURN    ${movie}

Get Invalid Movie Payload - Missing Title
    ${movie}=    Create Dictionary
    ...    synopsis=Um ladrão que invade sonhos
    ...    director=Christopher Nolan
    ...    genres=@{MOVIE_GENRES}
    ...    duration=7200
    ...    classification=14
    ...    poster=poster
    ...    releaseDate=2010-07-16
    RETURN    ${movie}
