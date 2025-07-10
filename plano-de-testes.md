# Plano de Testes para o Challenge PB AWS & AI for QE: Automação de Testes de Cinema

Este Plano de Testes detalha as atividades, estratégias e recursos necessários para o desenvolvimento do projeto de automação de testes do desafio final do Programa de Bolsa na Compass UOL, trilha "AWS & AI for QE". O foco principal será a validação funcional das funcionalidades de um sistema de reserva de ingressos e gerenciamento de cinema (back-end e front-end).

-----

## 1\. Introdução

O objetivo deste plano é guiar a criação de um projeto de automação de testes para uma aplicação de cinema, que consiste em um back-end e um front-end. O projeto visa garantir a qualidade do sistema, identificar defeitos, validar os requisitos funcionais e aplicar as melhores práticas de engenharia de qualidade. Será utilizada a ferramenta Robot Framework para a automação dos testes.

-----

## 2\. Escopo dos Testes

O escopo dos testes abrangerá as principais funcionalidades da aplicação de cinema, tanto no **back-end (API)** quanto no **front-end (interface de usuário)**.

https://github.com/luismagriss/challenge_final/blob/main/Cinema%20WebApp.jpg?raw=true

### 2.1. Funcionalidades a Serem Testadas:

  * **Gerenciamento de Filmes:**
      * Listagem de filmes (API e UI)
      * Criação de novos filmes (API e UI)
      * Atualização de informações de filmes (API e UI)
      * Exclusão de filmes (API e UI)
  * **Gerenciamento de Salas:**
      * Listagem de salas (API e UI)
      * Criação de novas salas (API e UI)
      * Atualização de informações de salas (API e UI)
      * Exclusão de salas (API e UI)
  * **Gerenciamento de Sessões:**
      * Listagem de sessões (API e UI)
      * Criação de novas sessões (API e UI)
      * Atualização de informações de sessões (API e UI)
      * Exclusão de sessões (API e UI)
  * **Funcionalidades de Usuário (Front-end):**
      * Visualização de filmes e detalhes.
      * Navegação entre as diferentes seções da aplicação.
      * Interação com os elementos da interface de usuário (botões, campos de texto, etc.).

### 2.2. Funcionalidades Fora do Escopo:

  * Testes de performance/carga.
  * Testes de segurança.
  * Testes de usabilidade extensivos (apenas validação funcional).
  * Testes de compatibilidade em múltiplos navegadores (foco em um navegador principal).

-----

## 3\. Objetivos dos Testes

  * **Garantir a Correta Implementação das Funcionalidades:** Assegurar que o sistema atenda aos requisitos funcionais especificados.
  * **Identificar e Reportar Defeitos:** Encontrar bugs, anomalias e comportamentos inesperados na aplicação.
  * **Assegurar a Qualidade do Software:** Validar que o sistema opere de forma estável e confiável.
  * **Fornecer Feedback Contínuo:** Oferecer informações sobre a qualidade do produto ao longo do ciclo de desenvolvimento.

-----

## 4\. Estratégias de Teste

A estratégia de testes será baseada em uma abordagem híbrida, combinando testes de API (back-end) e testes de UI (front-end), com foco em automação.

  * **Testes de API (Back-end):**
      * Serão desenvolvidos testes automatizados para validar os endpoints da API (GET, POST, PUT, DELETE) para as entidades de Usuários, Filmes, Salas e Sessões.
      * Validação de códigos de status HTTP, estruturas de resposta (JSON) e dados retornados.
      * Cenários de sucesso e falha para cada endpoint.
  * **Testes de UI (Front-end):**
      * Serão desenvolvidos testes automatizados para simular interações do usuário com a interface gráfica, navegando pelas diferentes telas e validando o comportamento esperado.
      * Validação da exibição correta de dados, mensagens de erro e elementos da UI.
      * Cobertura dos fluxos de criação, edição, visualização e exclusão através da interface do usuário.
  * **Testes de Regressão:**
      * Todos os testes automatizados serão executados periodicamente para garantir que novas alterações não introduzam defeitos em funcionalidades existentes.
  * **Design de Casos de Teste:**
      * Serão utilizados **mapas mentais** para auxiliar na identificação de cenários e casos de teste.
      * **Priorização de cenários de alto risco e de maior impacto.**
      * **Cenários complexos e de fluxo** serão abordados para garantir a cobertura de ponta a ponta.

-----

## 5\. Critérios de Entrada e Saída

### 5.1. Critérios de Entrada (Start Testing):

  * Ambiente de teste configurado e acessível (back-end e front-end).
  * Repositório Git inicializado e configurado.
  * Ferramentas e dependências de automação instaladas (Robot Framework, Browser Library, Requests Library, etc.).
  * Plano de Testes aprovado e revisado.

### 5.2. Critérios de Saída (End Testing):

  * Todos os cenários de teste críticos executados e com status final.
  * Cobertura de testes satisfatória (conforme métricas definidas).
  * Bugs críticos reportados e rastreados.
  * Relatório de testes gerado e documentado.
  * Documentação do projeto atualizada no README e/ou Wiki do repositório.

-----

## 6\. Ambiente de Teste

  * **Hardware:** Processador AMD Ryzen 7 5700G, 16GB RAM, com acesso à internet.
  * **Sistema Operacional:** Windows 11 Pro.
  * **Software:**
      * Python 3.13.4 (com pip para gerenciamento de pacotes).
      * Robot Framework.
      * Browser Library.
      * Requests Library.
      * Web browser (Chrome recomendado para compatibilidade com Selenium WebDriver).
      * Git para controle de versão.
      * Visual Studio Code.
  * **Dados de Teste:**
      * Dados de teste serão criados e gerenciados de forma programática ou através de arquivos de dados (ex: CSV, JSON) para garantir a independência dos testes.

-----

## 7\. Papéis e Responsabilidades

  * **Engenheiro de Qualidade (QE)**
      * Planejamento e design dos testes.
      * Desenvolvimento e execução dos scripts de automação.
      * Análise de resultados e criação de issues (bugs/melhorias).
      * Manutenção da documentação do projeto.
      * Gerenciamento do repositório Git.

-----

## 8\. Cronograma (Estimativa)

  * **Semana 1:**
      * Estudo e análise da aplicação (back-end e front-end).
      * Criação de mapa mental e identificação de cenários.
      * Definição da estrutura inicial do projeto de automação.
      * Configuração do ambiente de desenvolvimento.
      * Início da automação dos testes de API (endpoints básicos).
      * Continuação da automação de testes de API (cenários mais complexos).
      * Início da automação de testes de UI (fluxos principais).
  * **Semana 2:**

      * Refatoração e aplicação de padrões (Page Objects, Service Objects).
      * Finalização da automação de testes de UI.
      * Execução e análise dos testes.
      * Criação e rastreamento de issues (bugs/melhorias).
      * Documentação do projeto (README, Wiki).
      * Preparação para a apresentação.

-----

## 9\. Recursos Necessários

  * **Ferramentas de Automação:** Robot Framework, Browser Library, Requests Library.
  * **Controle de Versão:** Git e GitHub.
  * **Documentação:** Markdown para README/Wiki, ferramentas para mapas mentais (ex: XMind, MindMeister).
  * **Comunicação:** Plataformas para colaboração de colegas.

-----

## 10\. Gerenciamento de Defeitos

  * **Identificação:** Defeitos serão identificados durante a execução dos testes automatizados e manuais.
  * **Registro:** Todos os defeitos serão registrados como **Issues** no repositório GitHub, com informações detalhadas (passos para reprodução, resultados esperados vs. obtidos, capturas de tela/logs quando aplicável).
  * **Priorização:** As issues serão priorizadas com base no impacto e gravidade do defeito (ex: Crítico, Alto, Médio, Baixo).
  * **Acompanhamento:** As issues serão acompanhadas até a resolução.

-----

## 11\. Métricas de Teste

  * **Número de Casos de Teste Automatizados:** Quantidade de cenários cobertos pela automação.
  * **Porcentagem de Testes Passados/Falhos:** Indicação da estabilidade da aplicação.
  * **Cobertura de Automação:** Medida da proporção de funcionalidades cobertas por testes automatizados.
  * **Número de Issues Abertas/Fechadas:** Indicador da qualidade e progresso na correção de defeitos.
  * **Tempo Médio de Execução por Teste/Suite:** Crucial para pipelines de CI e para identificar testes lentos.
  * **Flakiness Rate (Taxa de Instabilidade):** Porcentagem de testes que falham e passam aleatoriamente, indicando a confiabilidade dos testes.

-----
