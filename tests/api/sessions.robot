*** Settings ***
Documentation        Testes de API do endpoint /movies

Resource             ../../resources/base.resource
Suite Setup          Start Administrator Session

*** Test Cases ***
Cenário: Criar uma nova sessão de filme com sucesso via API
    ${body}    Create Dictionary
    ...        movie=686930f4e4a72e49cf6cb239
    ...        theater=6859be19da2247b2b75991b8
    ...        datetime=2025-06-28T00:56:21.160Z
    ...        fullPrice=20
    ...        halfPrice=10
    

    ${response}    POST Endpoint /sessions    ${body}
