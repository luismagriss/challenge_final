*** Settings ***
Documentation     Este arquivo contém dados de fixture e palavras-chave relacionadas às salas de cinema (theaters).
...               Inclui salas com diferentes capacidades, nomes e configurações para testes diversos.
...               Usado em testes de criação, edição, listagem e vínculo com sessões de filmes.
...               Deve ser utilizado junto às fixtures de filmes e sessões para cenários integrados.

*** Keywords ***
Get Valid Theater Body
    [Arguments]    ${name}=Sala 3D Premium    ${capacity}=20    ${type}=IMAX
    ${body}=    Create Dictionary
    ...    name=${name}
    ...    capacity=${capacity}
    ...    type=${type}
    RETURN    ${body}