*** Settings ***
Documentation     Contém dados e palavras-chave para simular reservas de sessões de cinema.
...               Abrange reservas válidas, com assentos ocupados ou inválidos para testes negativos.
...               Essencial para testes de regras de negócio como disponibilidade, duplicidade e limitação de assentos.
...               Depende de sessões válidas previamente criadas para execução correta.

*** Keywords ***
Get Valid Reservation Body
    [Arguments]    ${session_id}=6859be2176fe3fb998efc29d    ${seats}=seat-1,seat-2    ${payment}=credit_card
    ${body}=    Create Dictionary
    ...    session=${session_id}
    ...    seats=${seats}
    ...    paymentMethod=${payment}
    RETURN    ${body}