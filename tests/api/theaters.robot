*** Settings ***
Documentation        Testes de API do endpoint /movies

Resource             ../../resources/base.resource
Suite Setup          Start Administrator Session

*** Test Cases ***
Cenário: Criar uma nova sala de cinema com sucesso via API
    ${random_body}    Generate random movie data
    ${body}        Create Dictionary
    ...            name=${random_body}[title]
    ...            capacity=20
    ...            type=standard

    ${response}    POST Endpoint /theaters    ${body}

