# Relatório de Execução de Testes – Automação de Testes de Cinema

**Data de Emissão:** 04 de julho de 2025  
**Ferramenta de Automação:** Robot Framework

---

## 1. Resumo

Este relatório apresenta os resultados consolidados da execução de testes automatizados e do registro de defeitos para o projeto **Automação de Testes de Cinema**.

A suíte de testes automatizados, focada nos fluxos críticos da aplicação, foi executada com **100% de sucesso**, indicando que as funcionalidades essenciais de **back-end (API)** e o fluxo principal de **reservas (UI)** estão estáveis.

No entanto, foram reportados **3 defeitos de gravidade Média** que impactam a experiência do usuário e funcionalidades secundárias da API. Esses defeitos, detalhados na [Seção 5](#5-defeitos-encontrados), incluem:

- Problemas na renderização de imagens
- Falha na funcionalidade de alteração de senha
- Componente de navegação da UI inativo

> **Resultado geral:** **APROVADO COM RESSALVAS**  
As funcionalidades core estão operantes, mas recomenda-se a correção dos defeitos antes da aprovação final para implantação.

---

## 2. Métricas da Execução Automatizada

Esta seção reflete os resultados da execução do `log.html`.

| Métrica                         | Resultado      |
|--------------------------------|----------------|
| Total de Testes Executados     | 15             |
| Testes Aprovados (Pass)        | 15             |
| Testes Reprovados (Fail)       | 0              |
| Taxa de Sucesso da Automação   | 100%           |
| Duração Total da Execução      | 15,59 segundos |

---

## 3. Escopo da Execução

O escopo da execução dos testes automatizados permaneceu o mesmo, focando em:

- **Testes de API (Back-end):** Autenticação, Gerenciamento (Filmes, Salas, Sessões) e Reservas.
- **Testes de UI (Front-end):** Fluxos de login e reserva de ingresso ponta a ponta (E2E).

---

## 4. Resultados Detalhados por Suíte de Teste

A execução da automação **não encontrou falhas** nos cenários validados.

| Suíte de Teste | Nº de Testes | Aprovados | Reprovados | Status    |
|----------------|--------------|-----------|------------|-----------|
| **Total**      | 15           | 15        | 0          | APROVADO  |
| Tests.Api      | 13           | 13        | 0          | APROVADO  |
| Tests.Ui       | 2            | 2         | 0          | APROVADO  |

---

## 5. Defeitos Encontrados

Os seguintes defeitos foram reportados e devem ser considerados na avaliação final da qualidade.

---

### 🔴 Bug #1: Imagens dos pôsteres de filmes não são exibidas

- **Descrição:** Ao acessar a página de filmes em cartaz, os pôsteres dos filmes não são carregados, exibindo apenas um ícone de imagem quebrada ou espaço vazio.
- **Passos para Reproduzir:**
  1. Acessar o endereço `http://localhost:3002/movies`
- **Resultado Esperado:** Os pôsteres de cada filme deveriam ser exibidos corretamente.
- **Resultado Atual:** As imagens não são processadas.
- **Gravidade:** Média  
- **Prioridade:** Média

---

### 🔴 Bug #2: Falha ao alterar a senha do usuário via API

- **Descrição:** A rota `POST /api/v1/auth/profile` da API não permite a alteração de senha, retornando um erro interno.
- **Passos para Reproduzir:**
  1. Fazer login via API com um usuário válido (ex: `regularuser@mail.com`)
  2. Enviar uma requisição `PUT` para `http://localhost:3000/api/v1/auth/profile` com o token de autenticação e o seguinte corpo:

    ```json
    {
      "name": "User",
      "currentPassword": "SENHA_ATUAL",
      "newPassword": "NOVA_SENHA"
    }
    ```

- **Resultado Esperado:** A API deveria retornar status `200 OK` e confirmar a alteração da senha.
- **Resultado Atual:** A API retorna erro `500 Internal Server Error` com a mensagem `"Illegal arguments: string, undefined"` e o seguinte stack trace:

    ```
    Error: Illegal arguments: string, undefined
        at _async (C:\...\bcryptjs\umd\index.js:305:15)
        at C:\...\bcryptjs\umd\index.js:335:11
        at new Promise (<anonymous>)
        at Object.compare (C:\...\bcryptjs\umd\index.js:334:16)
        at userSchema.methods.matchPassword (C:\...\User.js:92:23)
        at exports.updateProfile (C:\...\authController.js:141:34)
    ```

- **Gravidade:** Média  
- **Prioridade:** Média

---

### 🔴 Bug #3: Botão "Minhas Reservas" inativo na página de perfil

- **Descrição:** Na página de perfil do usuário, a aba/botão **"Minhas Reservas"** não possui funcionalidade.
- **Passos para Reproduzir:**
  1. Realizar o login com qualquer usuário
  2. Navegar até a página **"Perfil"**
  3. Clicar na aba **"Minhas Reservas"**
- **Resultado Esperado:** O usuário deveria ser redirecionado para a página com o histórico de suas reservas.
- **Resultado Atual:** Nenhuma ação ocorre e o usuário permanece na página de perfil.
- **Gravidade:** Média  
- **Prioridade:** Média

---
## 6. Cobertura de Testes

A cobertura de testes foi avaliada com base na suíte automatizada implementada no **Robot Framework** e na **collection Postman** fornecida para validação da API REST do Cinema App. A seguir, são apresentadas as áreas funcionais e endpoints contemplados nos testes.

### 6.1 Funcionalidades Testadas

#### 🔐 Autenticação
- Registro de novos usuários (`POST /api/v1/auth/register`)
- Login e geração de token de autenticação (`POST /api/v1/auth/login`)
- Acesso autorizado com token Bearer

#### 👤 Gestão de Usuários
- Obtenção de um usuário por ID (`GET /users/:id`)
- Atualização de dados do usuário (`PUT /users/:id`)
- Exclusão de usuário (`DELETE /users/:id`)
- Listagem de usuários com paginação e filtro por role (`GET /users`)
- Casos negativos: acesso não autorizado, não autenticado, conflito e não encontrado

#### 🎬 Gerenciamento de Filmes
- Criação de novo filme (`POST /api/v1/movies`)
- Edição de filme existente (`PUT /api/v1/movies/:id`)
- Listagem de todos os filmes (`GET /api/v1/movies`)
- Exclusão de filmes (`DELETE /api/v1/movies`)
- Obtenção de filme por ID (`GET /api/v1/movies/:id`)

#### 🪑 Sessões de Cinema
- Criação, edição e exclusão de sessões (`POST`, `PUT`, `DELETE /sessions`)
- Reset de assentos da sessão (`PUT /sessions/:id/reset-seats`)
- Consulta por ID (`GET /sessions/:id`)

#### 🧾 Reservas
- Criação de reservas (`POST /api/v1/reservations`)
- Obtenção de reservas do usuário logado (`GET /reservations/me`)
- Consulta de reserva por ID (`GET /reservations/:id`)
- Atualização de status da reserva (admin) (`PUT /reservations/:id`)
- Exclusão de reserva (admin) (`DELETE /reservations/:id`)

### 6.2 Abrangência dos Testes

| Módulo           | Endpoints Cobertos | Métodos HTTP | Casos Positivos | Casos Negativos |
|------------------|--------------------|---------------|------------------|------------------|
| Autenticação     | 2                  | POST          | ✅               | ✅               |
| Usuários         | 6+                 | GET, PUT, DELETE | ✅           | ✅               |
| Filmes           | 5                  | GET, POST, PUT, DELETE | ✅     | ✅               |
| Sessões          | 5+                 | GET, PUT, DELETE | ✅           | ✅               |
| Reservas         | 6+                 | GET, POST, PUT, DELETE | ✅     | ✅               |

> ✅ *Casos negativos* incluem testes de autorização, autenticação, dados inválidos e recursos inexistentes.

---

### 6.4 Recomendação

- Expandir a suíte de testes para cobrir os pontos não contemplados, especialmente:
  - Testes visuais ou verificações automatizadas de atributos de imagem.
  - Validação de botões e interações da UI com foco em usabilidade.

---

**Conclusão:** A cobertura atual contempla com solidez as principais funcionalidades da aplicação (API e fluxo E2E de reserva), mas há espaço para melhoria na cobertura de casos secundários e testes de interface visual.


## 7. Conclusão e Recomendações

### ✅ Conclusão:

A suíte de testes automatizados validou com sucesso os **fluxos de negócio mais críticos**, como a criação de sessões via API e a jornada de reserva de ingresso na UI. Isso indica uma **base funcional sólida**.

Contudo, os 3 defeitos reportados demonstram a necessidade de **refinamento na interface do usuário** e em funcionalidades **secundárias da API**.

> **A qualidade do software é boa para as funcionalidades principais**, mas requer atenção aos pontos levantados para garantir uma **experiência completa e segura ao usuário**.

---

### 🛠️ Recomendações:

- **Priorizar Correção dos Bugs:**
  - A equipe de desenvolvimento deve focar na resolução dos três defeitos reportados.
  - Atenção especial ao **Bug #2**, que representa uma vulnerabilidade na gestão de contas de usuário.

- **Expandir a Cobertura de Testes:**
  - Implementar **testes de regressão visual** ou verificações como `naturalWidth > 0` para garantir o carregamento correto de pôsteres e imagens.

- **Ação Imediata:**
  - Proceder com a correção dos defeitos.
  - Executar nova rodada de testes (automatizados e manuais focados nos bugs) para validar as correções e garantir ausência de regressões.

> A aprovação final para **implantação** fica condicionada à **validação dessas correções**.
