import random

# Lista de todas as fileiras e números de assentos possíveis
ALL_ROWS = ['A', 'B', 'C', 'D', 'E', 'F', 'G', 'H']
ALL_NUMBERS = list(range(1, 11))
# Tipos de ingresso possíveis
SEAT_TYPES = ['full', 'half']

def get_random_available_seats(occupied_seats_list: list, seats_to_book: int = 2):
    """
    Gera uma lista de assentos disponíveis aleatórios, evitando os que já estão ocupados.

    :param occupied_seats_list: Uma lista de dicionários de assentos ocupados (ex: [{'row': 'A', 'number': 1}, ...]).
    :param seats_to_book: O número de assentos a serem selecionados aleatoriamente.
    :return: Uma lista de dicionários de assentos formatados para a requisição.
    """
    all_possible_seats = []
    # Gera um conjunto com todos os assentos possíveis no formato "A1", "A2", etc.
    for row in ALL_ROWS:
        for number in ALL_NUMBERS:
            all_possible_seats.append(f"{row}{number}")

    occupied_seat_identifiers = set()
    # Cria um conjunto de identificadores para os assentos ocupados para uma busca rápida
    for seat in occupied_seats_list:
        occupied_seat_identifiers.add(f"{seat['row']}{seat['number']}")

    # Filtra a lista de todos os assentos, mantendo apenas os que não estão no conjunto de ocupados
    available_seats = [
        seat for seat in all_possible_seats if seat not in occupied_seat_identifiers
    ]

    if len(available_seats) < seats_to_book:
        raise Exception(f"Não há assentos disponíveis suficientes. Solicitado: {seats_to_book}, Disponível: {len(available_seats)}")

    # Escolhe aleatoriamente o número de assentos desejado da lista de disponíveis
    selected_seats_identifiers = random.sample(available_seats, seats_to_book)

    reservation_seats = []
    # Formata os assentos selecionados no formato de dicionário para o corpo da requisição
    for seat_identifier in selected_seats_identifiers:
        reservation_seats.append({
            "row": seat_identifier[0],  # A primeira letra é a fileira
            "number": int(seat_identifier[1:]),  # O restante é o número
            "type": random.choice(SEAT_TYPES) # Escolhe um tipo de ingresso aleatoriamente
        })

    return reservation_seats
