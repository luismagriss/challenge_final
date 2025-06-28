# Cenários de Teste Gherkin: Cinema App

Este documento contém os cenários de teste em formato **Gherkin**, elaborados com base no *Plano de Testes v1.1* e nas especificações da aplicação **Cinema App**.

---

## Funcionalidade: Módulo de Autenticação

**Prioridade:** Máxima

Como um usuário da aplicação, eu quero me registrar, autenticar e gerenciar minha sessão para acessar as funcionalidades correspondentes ao meu perfil.

---

### 🟢 Cenário de Caminho Feliz - Prioridade Máxima

**Cenário:** Registro de um novo usuário com sucesso

```gherkin
Dado que sou um "Visitante" na página de registro
E o e-mail "novo.usuario@example.com" não está cadastrado no sistema
Quando eu preencho o campo "Nome" com "Novo Usuário"
E preencho o campo "Email" com "novo.usuario@example.com"
E preencho o campo "Senha" com "Senha@123"
E clico no botão "Registrar"
Então a API deve receber uma requisição POST para o endpoint "/api/v1/auth/register"
E a API deve retornar o status 201 Created
E o usuário deve ser redirecionado para a página de "Login"
E a mensagem de sucesso "Registro realizado com sucesso!" deve ser exibida
```

---

### 🟠 Esquema de Cenário para Validação - Prioridade Alta

**Esquema do Cenário:** Tentativa de login com credenciais inválidas

```gherkin
Dado que sou um "Visitante" na página de login
Quando eu preencho o campo "Email" com "<email>"
E preencho o campo "Senha" com "<senha>"
E clico no botão "Entrar"
Então a API de autenticação deve retornar o status 401 Unauthorized
E a mensagem de erro "Email ou senha inválidos" deve ser exibida na UI
E eu devo permanecer na página de "Login"
```

**Exemplos:**

| email                                                                     | senha          |
| ------------------------------------------------------------------------- | -------------- |
| [usuario.inexistente@example.com](mailto:usuario.inexistente@example.com) | qualquerSenha  |
| [user@example.com](mailto:user@example.com)                               | senhaIncorreta |

---

### 🟠 Cenário de Integração UI-API - Prioridade Alta

**Cenário:** Login de Administrador com sucesso e validação de token

```gherkin
Dado que um "Administrador" com email "admin@example.com" e senha "admin123" existe no sistema
Quando eu realizo o login como "Administrador" através da UI
Então a API deve retornar o status 200 OK com um token JWT no corpo da resposta
E o token JWT deve ser armazenado no localStorage do navegador
E eu devo ser redirecionado para a Página Inicial
E o nome "Administração" deve ser exibido no cabeçalho da página
```

---

### 🔴 Cenário de Erro Crítico - Prioridade Alta

**Cenário:** Tentar registrar um usuário com um e-mail já existente

```gherkin
Dado que sou um "Visitante" na página de registro
E um usuário com o e-mail "user@example.com" já está cadastrado
Quando eu preencho o campo "Email" com "user@example.com"
E preencho os outros campos de registro
E clico no botão "Registrar"
Então a API deve retornar o status 400 Bad Request
E a mensagem de erro "Este e-mail já está em uso" deve ser exibida na UI
```

---

**Cenário:** Acessar o link do Painel Administrativo leva a uma página de erro 404

```gherkin
Dado que um "Administrador" realizou o login com sucesso
E o link "Administração" está visível no cabeçalho
Quando o administrador clica no link "Administração"
Então ele deve ser redirecionado para uma página de erro
E a página deve exibir o status "404" com a mensagem "Página Não Encontrada"
```

---

### 🟡 Cenário Complementar - Prioridade Média

**Cenário:** Usuário atualiza seu nome no perfil com sucesso

```gherkin
Dado que um "Usuário Registrado" com nome "Nome Antigo" realizou o login com sucesso
Quando ele navega para a página "Meu Perfil"
E preenche o campo "Nome" com "Nome Novo"
E clica no botão "Salvar Alterações"
Então a API deve receber uma requisição PUT para o endpoint "/api/v1/auth/profile"
E a API deve retornar o status 200 OK
E a mensagem de sucesso "Perfil atualizado com sucesso!" deve ser exibida
E o nome no cabeçalho da página deve ser atualizado para "Nome Novo"
```

---

## Funcionalidade: Painel Administrativo - Gerenciamento de Filmes (API)

**Nota:** Devido à ausência da UI do Painel Administrativo (resultando em erro 404), os cenários a seguir foram adaptados para teste direto via API.
**Prioridade:** Alta

Como um Administrador, eu quero gerenciar o catálogo de filmes via API para manter a lista de filmes atualizada para os usuários.

---

### 🟢 Cenário de Caminho Feliz (API) - Prioridade Máxima

**Cenário:** Criar um novo filme com sucesso via API como Administrador

```gherkin
Dado que um "Administrador" obteve um token de autenticação válido via API
Quando ele envia uma requisição POST para o endpoint "/api/v1/movies" com o token e os dados do filme "Ghost In The Shell"
Então a API deve retornar o status 201 Created
E a resposta da API deve conter o objeto do filme "Ghost In The Shell"
```

---

### 🟠 Cenário de Validação de Permissão - Prioridade Alta

**Cenário:** Usuário comum tenta acessar a API de criação de filmes

```gherkin
Dado que um "Usuário Registrado" realizou o login com sucesso e obteve um token JWT
Quando este usuário tenta enviar uma requisição POST para o endpoint "/api/v1/movies" com dados de um novo filme
Então a API deve retornar o status 403 Forbidden
E a resposta da API deve conter uma mensagem de erro de permissão
```

---

### 🟠 Cenário de Exclusão (API) - Prioridade Alta

**Cenário:** Excluir um filme existente via API como Administrador

```gherkin
Dado que um "Administrador" obteve um token de autenticação válido via API
E o filme "Filme a ser Excluído" existe no sistema com um ID conhecido
Quando ele envia uma requisição DELETE para o endpoint "/api/v1/movies/{id_do_filme}" com o token de administrador
Então a API deve retornar o status 204 No Content
```

---

### 🟡 Cenário Complementar (API) - Prioridade Média

**Cenário:** Atualizar os detalhes de um filme existente via API

```gherkin
Dado que um "Administrador" obteve um token de autenticação válido
E existe um filme com ID conhecido e gênero "Ficção"
Quando ele envia uma requisição PUT para "/api/v1/movies/{id_do_filme}" com o gênero atualizado para "Ficção Científica"
Então a API deve retornar o status 200 OK
E a resposta da API deve conter o objeto do filme com o gênero "Ficção Científica"
```

---

## Funcionalidade: Módulo de Reservas (Fluxo de Usuário Logado)

**Prioridade:** Máxima

Como um Usuário Registrado, eu quero reservar assentos para uma sessão de filme para garantir meu lugar no cinema.

---

### 🟢 Cenário de Caminho Feliz - Prioridade Máxima

**Cenário:** Realizar uma reserva de ponta a ponta com sucesso

```gherkin
Dado que um "Usuário Registrado" realizou o login com sucesso
E existe o filme "Duna: Parte Dois" com uma sessão disponível às "20:00"
Quando o usuário navega para a página de detalhes do filme "Duna: Parte Dois"
E seleciona a sessão das "20:00"
E na tela de assentos, seleciona os assentos "F7" e "F8"
E clica no botão "Confirmar Seleção"
E na tela de checkout, seleciona o método de pagamento "Cartão de Crédito"
E clica em "Finalizar Reserva"
Então a API de reservas deve receber uma requisição POST para "/api/v1/reservations"
E a API deve retornar o status 201 Created
E o usuário deve ser redirecionado para a página de "Confirmação de Reserva"
E a mensagem "Sua reserva foi confirmada com sucesso!" deve ser exibida
```

---

### 🔴 Cenário de Erro Crítico - Prioridade Alta

**Cenário:** Tentar reservar um assento já ocupado

```gherkin
Dado que um "Usuário Registrado" está logado
E na sessão das "20:00" do filme "Duna: Parte Dois", o assento "A1" já está reservado
Quando o usuário seleciona a sessão das "20:00"
E na tela de assentos, tenta clicar no assento "A1"
Então o assento "A1" deve estar visualmente desabilitado (ex: cor diferente)
E nenhuma ação de seleção deve ocorrer para o assento "A1"
```

---

### 🟠 Cenário de Integração UI-API - Prioridade Alta

**Cenário:** Visualizar histórico de reservas

```gherkin
Dado que um "Usuário Registrado" realizou o login com sucesso
E este usuário possui uma reserva confirmada para o filme "Interestelar" no assento "B2"
Quando o usuário navega para a página "Minhas Reservas" em seu perfil
Então a UI deve fazer uma requisição GET para o endpoint "/api/v1/reservations/me"
E a API deve retornar o status 200 OK com uma lista de reservas
E um card de reserva para o filme "Interestelar" com o assento "B2" deve ser exibido na tela
```

---

### 🟡 Cenário de Caso de Borda - Prioridade Média

**Cenário:** Tentar prosseguir para o checkout sem selecionar assentos

```gherkin
Dado que um "Usuário Registrado" está logado e na tela de seleção de assentos
Quando ele clica no botão "Confirmar Seleção" sem ter selecionado nenhum assento
Então o botão "Confirmar Seleção" deve permanecer desabilitado ou uma mensagem de erro "Selecione pelo menos um assento" deve ser exibida
E o usuário não deve ser redirecionado para a página de checkout
```

---

## Funcionalidade: Módulo de Catálogo de Filmes (Visão Pública)

**Prioridade:** Média

Como um Visitante, eu quero ver os filmes em cartaz para decidir o que assistir.

---

### 🟡 Cenário Complementar - Prioridade Média

**Cenário:** Visitante visualiza a lista de filmes na página inicial

```gherkin
Dado que um "Visitante" acessa a página inicial da aplicação
E existem filmes cadastrados no sistema
Quando a página termina de carregar
Então a UI deve fazer uma requisição GET para o endpoint "/api/v1/movies"
E a API deve retornar o status 200 OK com uma lista de filmes
E uma lista de pôsteres de filmes deve ser exibida na tela
```
