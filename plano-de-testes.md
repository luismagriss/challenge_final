# Plano de Testes: Cinema App - Challenge PB AWS & AI for QE

**Versão:** 1.1  
**Data:** 26 de junho de 2025  
**Autor:** Luis Magris de Sousa, Estagiário em Engenharia de Qualidade.

---

## 1. Introdução e Resumo

Este documento estabelece o Plano de Testes para a aplicação **Cinema App**, um sistema composto por um Front-end em React e um Back-end RESTful em Node.js. O objetivo deste plano é guiar de forma estruturada todas as atividades de teste funcional e de integração, garantindo a qualidade e a conformidade da aplicação com os requisitos definidos no escopo do desafio **Challenge PB AWS & AI for QE**.

O projeto de testes visa validar as funcionalidades da aplicação de ponta a ponta, abrangendo desde a interação do usuário na interface até as regras de negócio e a persistência de dados na API. Através de uma estratégia de automação com **Robot Framework**, buscaremos identificar defeitos, garantir a estabilidade e fornecer uma avaliação clara da qualidade do produto final.

---

## 2. Escopo dos Testes

### 2.1 Funcionalidades em Escopo

As seguintes funcionalidades serão testadas de forma exaustiva, cobrindo tanto a camada de API (Back-end) quanto a de UI (Front-end):

#### **Módulo de Autenticação**
- Registro de novos usuários  
- Login com credenciais válidas e inválidas  
- Logout e invalidação de sessão  
- Gestão de perfil do usuário (visualização e atualização)  
- Controle de acesso baseado em papéis (Visitante, Usuário, Administrador)

#### **Módulo de Catálogo de Filmes (Visão Pública)**
- Listagem e visualização de filmes em cartaz  
- Visualização de detalhes de um filme específico (sinopse, diretor, duração etc.)  
- Visualização de sessões disponíveis para um filme

#### **Módulo de Reservas (Usuário Logado)**
- Seleção de filme e sessão  
- Visualização e seleção de assentos em um mapa interativo  
- Validação de assentos (disponíveis, ocupados, selecionados)  
- Simulação do processo de checkout e pagamento  
- Confirmação da reserva  
- Visualização do histórico de reservas

#### **Painel Administrativo (Administrador)**
- CRUD de Filmes  
- CRUD de Salas  
- CRUD de Sessões  
- Gerenciamento de Reservas  
- Gerenciamento de Usuários

### 2.2 Funcionalidades Fora de Escopo

- **Testes de Performance e Carga**
- **Testes de Segurança Aprofundados**
- **Testes de Usabilidade**
- **Testes de Compatibilidade entre navegadores**

---

## 3. Estratégia de Teste

### 3.1 Testes de API (Back-end)

- **Ferramenta:** `RequestsLibrary` (Robot Framework)  
- **Validações:**  
  - Status Codes  
  - Contrato da API (estrutura JSON)  
  - Regras de Negócio  
  - Integridade dos Dados

### 3.2 Testes de UI (Front-end)

- **Ferramenta:** `Browser Library` (Robot Framework)  
- **Validações:**  
  - Renderização de componentes  
  - Navegação e fluxos  
  - Interatividade  
  - Feedback visual (mensagens)

### 3.3 Testes de Integração (End-to-End)

- **Validação de fluxos completos entre UI e API**

**Exemplo de Cenário**:  
> UI: Admin cria filme → API: verificação no banco → UI: visitante visualiza filme

### 3.4 Testes de Regressão

- A suíte completa será reutilizada a cada nova entrega

### 3.5 Design de Casos de Teste

- Técnicas: **Partição de Equivalência**, **Valor Limite**  
- Linguagem: **Gherkin (Dado, Quando, Então)**

---

## 4. Ambiente, Ferramentas e Recursos

| Categoria        | Ferramenta/Recurso                    |
|------------------|---------------------------------------|
| Hardware         | Computador com acesso à internet      |
| Software         | Python 3.13.4, Node.js                  |
| Framework        | Robot Framework                       |
| Bibliotecas      | Browser Library, RequestsLibrary      |
| Navegador        | Google Chrome (última versão)         |
| IDE              | Visual Studio Code                    |
| Controle de Versão | Git e GitHub                       |
| CI/CD            | GitHub Actions                        |
| Gerenciamento    | Jira                                  |

---

## 5. Papéis e Responsabilidades

| Papel                  | Responsabilidades                                                                 |
|------------------------|------------------------------------------------------------------------------------|
| Engenheiro de Qualidade | Planejar, desenvolver e executar os testes, analisar e reportar resultados         |

---

## 6. Critérios de Entrada e Saída

### 6.1 Critérios de Entrada
- Front-end e Back-end implantados  
- Documentação da API disponível  
- Acesso ao repositório configurado  
- Plano de Testes revisado e aprovado

### 6.2 Critérios de Saída
- 100% dos testes executados  
- Nenhum defeito crítico aberto  
- Todos os bugs registrados no Jira  
- Relatório final e código no repositório

---

## 7. Gerenciamento de Defeitos

- **Ferramenta:** Jira  
- **Registro de Defeitos inclui:**
  - Título (Summary)
  - Descrição detalhada
  - Evidências (prints, logs)
  - Prioridade
  - Componente afetado
  - Fluxo de trabalho: `TO DO → IN PROGRESS → IN REVIEW → DONE`

---

## 8. Métricas de Avaliação

| Métrica                   | Descrição                                         | Meta                      |
|---------------------------|---------------------------------------------------|---------------------------|
| Cobertura de Requisitos   | % de requisitos testados                         | > 90%                     |
| Total de Casos de Teste   | Número de testes automatizados                   | Conforme planejamento     |
| Sucesso nos Testes        | % de testes que passaram                         | > 95% na suíte de regressão |
| Defeitos Abertos          | Número por prioridade                            | 0 críticos/bloqueadores   |
| Densidade de Defeitos     | Bugs por funcionalidade                          | Monitoramento contínuo    |

---

## 9. Riscos e Planos de Mitigação

| Risco                              | Probabilidade | Impacto | Mitigação                                                                 |
|-----------------------------------|---------------|---------|----------------------------------------------------------------------------|
| Tempo limitado (2 semanas)        | Alta          | Alta    | Priorizar cenários críticos e reutilizar código                           |
| Instabilidade do ambiente         | Média         | Alta    | Retries nos scripts e contato direto com o instrutor                      |
| Mudanças tardias nos requisitos   | Baixa         | Média   | Modularização da automação e documentação dos impactos                    |

---

## 10. Cronograma e Entregáveis

### 10.1 Cronograma (2 Semanas)

**Semana 1: Planejamento e Automação Core**
- Dias 1-2: Estudo da aplicação, finalização do plano e setup
- Dias 3-5: Automação de testes de API e base da UI

**Meta da Semana:** Estrutura de testes funcional e API coberta

**Semana 2: End-to-End e Encerramento**
- Dias 6-8: Automação de fluxos completos e painel admin
- Dias 9-10: Execução final, relatório, refatoração e entrega

**Meta da Semana:** Projeto finalizado e pronto para avaliação

### 10.2 Entregáveis

- Código-fonte da automação no GitHub  
- `README.md` com instruções de execução  
- Relatórios `log.html` e `report.html`  
- Quadro de defeitos no Jira  
- Este **Plano de Testes**

---
