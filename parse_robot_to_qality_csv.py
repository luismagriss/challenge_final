
import os
import csv
import re

def extrair_testes_robot(file_path):
    testes = []
    with open(file_path, "r", encoding="utf-8") as f:
        lines = f.readlines()

    current_test = {}
    steps = []
    in_test_case = False

    for line in lines:
        line = line.strip()

        if line.startswith("*** Test Cases ***"):
            continue

        # Início de um novo caso de teste
        if re.match(r"^[^\s].+", line) and not line.startswith("["):
            if in_test_case and current_test:
                current_test["Test Steps"] = "\n".join(steps)
                testes.append(current_test)
                current_test = {}
                steps = []

            current_test["Name"] = line
            in_test_case = True
            continue

        if in_test_case:
            if line.startswith("[Documentation]"):
                current_test["Objective"] = line.replace("[Documentation]", "").strip()
            elif line.startswith("[Tags]"):
                tags = line.replace("[Tags]", "").strip()
                if "prioridade=" in tags.lower():
                    prioridade = re.findall(r"prioridade=([\w\s]+)", tags, flags=re.IGNORECASE)
                    current_test["Preconditions"] = f"Prioridade: {prioridade[0]}" if prioridade else ""
                else:
                    current_test["Preconditions"] = tags
            elif line.startswith("#") or "Set Variable" in line or "Input Text" in line:
                current_test.setdefault("Test Data", "")
                current_test["Test Data"] += line + "\n"
            elif "Should" in line or "Page Should" in line or "Element Should" in line:
                current_test["Expected Result"] = line
                steps.append(line)
            elif line:
                steps.append(line)

    if in_test_case and current_test:
        current_test["Test Steps"] = "\n".join(steps)
        testes.append(current_test)

    return testes


def gerar_csv_para_qality(testes, output_path):
    headers = [
        "Name", "Objective", "Preconditions", "Test Steps",
        "Test Data", "Expected Result", "Status", "Comment"
    ]
    with open(output_path, mode="w", encoding="utf-8", newline="") as f:
        writer = csv.DictWriter(f, fieldnames=headers)
        writer.writeheader()
        for teste in testes:
            writer.writerow({
                "Name": teste.get("Name", ""),
                "Objective": teste.get("Objective", ""),
                "Preconditions": teste.get("Preconditions", ""),
                "Test Steps": teste.get("Test Steps", ""),
                "Test Data": teste.get("Test Data", "").strip(),
                "Expected Result": teste.get("Expected Result", ""),
                "Status": "UNDEFINED",
                "Comment": ""
            })


def processar_pasta_robot(pasta_robot, output_csv):
    all_testes = []
    for file in os.listdir(pasta_robot):
        if file.endswith(".robot"):
            caminho = os.path.join(pasta_robot, file)
            testes = extrair_testes_robot(caminho)
            all_testes.extend(testes)

    gerar_csv_para_qality(all_testes, output_csv)
    print(f"CSV gerado com {len(all_testes)} testes: {output_csv}")


if __name__ == "__main__":
    # Exemplo: processar_pasta_robot("tests/ui", "saida_qality.csv")
    pasta = input("Caminho da pasta com arquivos .robot: ").strip()
    saida = input("Caminho do arquivo CSV de saída: ").strip()
    processar_pasta_robot(pasta, saida)
