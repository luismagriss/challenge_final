
#  Cinema App – Desafio Final | Programa de Formação Compass UOL

Este projeto consiste na implementação de uma suíte de testes automatizados para a API e interface do sistema **Cinema App**, como parte do desafio final do programa de formação da Compass UOL. O objetivo principal é validar funcionalidades críticas da aplicação por meio de testes automatizados com **Robot Framework** e **Postman**, gerando evidências para rastreabilidade e integração com o QAlity Plus (Jira).

---

##  Sumário

- [Tecnologias Utilizadas](#-tecnologias-utilizadas)
- [Estrutura do Projeto](#-estrutura-do-projeto)
- [Como Executar os Testes](#-como-executar-os-testes)
- [Evidências e Resultados](#-evidências-e-resultados)
- [Cobertura de Testes](#-cobertura-de-testes)
- [Melhorias e Recomendações](#-melhorias-e-recomendações)

---

##  Tecnologias Utilizadas

- [Robot Framework](https://robotframework.org/) com:
  - `RequestsLibrary`
  - `FakerLibrary`
  - `OperatingSystem`
- [Postman](https://www.postman.com/)
- [Python 3.11+](https://www.python.org/)
- [Node.js / Cinema App API](https://github.com/CompassHQ/backend-cinema)
- GitHub Actions (CI)
- QAlity Plus (Plugin para Jira)

---

##  Estrutura do Projeto

```bash
challenge_final/
├── postman/
│   └── Cinema App.postman_collection.json
├── robot/
│   ├── tests/
│   │   ├── api/
│   │   └── ui/
│   ├── resources/
│   ├── variables/
│   └── results/
├── evidence/
│   ├── csv/
│   ├── html/
│   └── output.xml
├── scripts/
│   └── gerar_csv_qality.py
├── README.md
└── requirements.txt
```

---

##  Como Executar os Testes

### 1. Clone o repositório

```bash
git clone https://github.com/luismagriss/challenge_final.git
cd challenge_final
```

### 2. Instale as dependências

```bash
pip install -r requirements.txt
```

> Certifique-se de estar com o Python 3.11+ e o Node.js instalados.

### 3. Configure o ambiente da API (backend)

- Utilize o repositório oficial: [backend-cinema](https://github.com/CompassHQ/backend-cinema)
- Execute a API localmente em `localhost:3000` ou `3002`

### 4. Execute os testes Robot

```bash
robot -d ./robot/results robot/tests/
```

---

##  Evidências e Resultados

As evidências da execução dos testes são salvas automaticamente na pasta `robot/results`:

- `log.html` – Detalhamento da execução
- `report.html` – Relatório resumido
- `output.xml` – Utilizado para análise e extração de resultados

---

##  Cobertura de Testes

A cobertura contempla os seguintes módulos da aplicação:

### API
- Autenticação (register, login)
- Usuários (CRUD + busca + permissões)
- Filmes (CRUD)
- Sessões (CRUD + reset assentos)
- Reservas (E2E + status + histórico)

### UI (E2E)
- Login de usuários
- Fluxo de reserva de ingressos

> Para detalhes completos, consulte a [seção de cobertura de testes](docs/CoberturaDeTestes.md).

---

##  Melhorias e Recomendações

- Automatizar a verificação de atributos visuais (exibição de pôsteres)
- Criar testes dedicados para alteração de senha via API
- Expandir testes de usabilidade e navegação na interface
- Incluir cenários de regressão visual

---

##  Autor

Desenvolvido por **Luis M. de Sousa** como parte do desafio final no programa de formação da **Compass UOL** – 2025.  
🔗 [LinkedIn](https://www.linkedin.com/in/luismagriss)

---
