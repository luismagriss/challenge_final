*** Settings ***
Documentation     Este arquivo define dados de fixture e keywords para sessões de filmes.
...               As fixtures cobrem sessões válidas, inválidas e cenários de conflito de horário ou sala.
...               Usado em testes que envolvem a criação, edição ou listagem de sessões via API.
...               Requer dados de filmes e salas válidas para funcionamento completo.

*** Variables ***
${occupied_seat}    F7
${session_id}       6859beb409b430d4e6e3e693
${regular_user}     regularuser@mail.com
${user_password}    teste123
${admin_user}       teste@qa.com

*** Keywords ***
Get Valid Session Body
    [Arguments]    ${movie_id}=6859be2176fe3fb998efc29d    ${theater_id}=6859be19da2247b2b75991b8
    ${body}=    Create Dictionary
    ...    movie=${movie_id}
    ...    theater=${theater_id}
    ...    datetime=2025-06-28T00:56:21.160Z
    ...    fullPrice=20
    ...    halfPrice=10
    RETURN    ${body}