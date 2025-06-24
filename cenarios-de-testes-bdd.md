# Cenários de Testes BDD

## Funcionalidade: Autenticação de Usuário
```
Cenário: Registrar um novo usuário com sucesso (UI e API)
  Dado que sou um "Visitante"
  Quando eu acesso a página de registro no Front-end
  E preencho o campo "Nome" com "Novo Usuário Teste"
  E preencho o campo "Email" com um email único gerado dinamicamente
  E preencho o campo "Senha" com "SenhaSegura123!"
  E clico no botão "Registrar"
  Então a requisição **POST** para `/api/v1/auth/register` deve ser enviada com os dados fornecidos
  E a **API** deve retornar o **status 200 OK**
  E a resposta da **API** deve conter um **token JWT**
  E a resposta da **API** deve conter os dados do usuário registrado com `role: "user"`
  E o usuário deve ser redirecionado para a página inicial do Front-end
  E uma mensagem de sucesso "Registro bem-sucedido!" deve ser exibida na UI

Cenário: Tentar registrar com email duplicado (UI e API)
  Dado que sou um "Visitante"
  E que o email "usuario_existente@example.com" já está registrado no sistema
  Quando eu acesso a página de registro no Front-end
  E preencho o campo "Nome" com "Duplicado Teste"
  E preencho o campo "Email" com "usuario_existente@example.com"
  E preencho o campo "Senha" com "senhaDuplicada456"
  E clico no botão "Registrar"
  Então a requisição **POST** para `/api/v1/auth/register` deve ser enviada
  E a **API** deve retornar o **status 400 Bad Request**
  E a resposta da **API** deve conter `success: false` e `error.code: "VALIDATION_ERROR"` ou similar
  E a resposta da **API** deve conter uma mensagem de erro indicando que o email já existe
  E uma mensagem de erro "Email já cadastrado" deve ser exibida visualmente na UI
  E eu devo permanecer na página de registro

Cenário: Logar como usuário e acessar perfil (UI e API)
  Dado que sou um "Usuário" com email "user@example.com" e senha "password123"
  Quando eu acesso a página de login no Front-end
  E preencho o campo "Email" com "user@example.com"
  E preencho o campo "Senha" com "password123"
  E clico no botão "Login"
  Então a requisição **POST** para `/api/v1/auth/login` deve ser enviada
  E a **API** deve retornar o **status 200 OK**
  E a resposta da **API** deve conter um **token JWT**
  E o token JWT deve ser armazenado no `localStorage` do navegador
  E eu devo ser redirecionado para a página inicial do Front-end
  Quando eu clico no link "Perfil" no cabeçalho
  Então uma requisição **GET** para `/api/v1/auth/me` deve ser enviada com o token JWT no header `Authorization`
  E a **API** deve retornar o **status 200 OK**
  E a página de perfil deve exibir o nome e email do usuário: "user@example.com"

Cenário: Fazer logout e ser redirecionado (UI e API)
  Dado que sou um "Usuário" logado
  Quando eu clico no link "Logout" no cabeçalho do Front-end
  Então o token JWT deve ser removido do `localStorage`
  E eu devo ser redirecionado para a página de login ou inicial (pública)
  Quando eu tento acessar uma rota protegida como `/profile`
  Então devo ser automaticamente redirecionado para a página de login

Cenário: Tentar acessar rota de administrador como usuário comum (UI e API)
  Dado que sou um "Usuário" logado
  Quando eu tento acessar a rota `/admin/movies` diretamente pela URL
  Então o Front-end deve redirecionar para uma página de erro ou login
  E uma requisição para uma rota de administrador (`/api/v1/movies`) com token de usuário deve retornar **status 403 Forbidden** na **API**

```
## Funcionalidade: Navegação e Exibição de Filmes
```
Cenário: Visualizar a lista de filmes em cartaz na página inicial (UI e API)
  Dado que sou um "Visitante"
  Quando eu acesso a página inicial do Front-end (`/`)
  Então uma requisição **GET** para `/api/v1/movies` deve ser enviada
  E a **API** deve retornar o **status 200 OK** com uma lista de filmes
  E os pôsteres dos filmes e informações básicas (título, classificação, gênero) devem ser exibidos em grid na UI
  E o layout da página deve ser responsivo para diferentes tamanhos de tela

Cenário: Filtrar filmes por título e validar resultados (UI e API)
  Dado que sou um "Visitante"
  E que existem filmes com os títulos "Matrix", "Matrix Reloaded" e "V de Vingança"
  Quando eu acesso a página inicial no Front-end
  E eu digito "Matrix" no campo de busca
  E clico no botão "Buscar"
  Então uma requisição **GET** para `/api/v1/movies` com o parâmetro `title=Matrix` deve ser enviada
  E a **API** deve retornar o **status 200 OK**
  E a resposta da **API** deve conter apenas os filmes que contêm "Matrix" no título
  E apenas os filmes "Matrix" e "Matrix Reloaded" devem ser exibidos na lista

Cenário: Exibir detalhes de um filme específico, incluindo sessões (UI e API)
  Dado que sou um "Visitante"
  E que existe um filme "O Poderoso Chefão" com o ID "filme_dch3x"
  Quando eu clico no pôster do filme "O Poderoso Chefão" na lista de filmes
  Então eu sou redirecionado para a página `/movies/filme_dch3x`
  E uma requisição **GET** para `/api/v1/movies/filme_dch3x` deve ser enviada
  E a **API** deve retornar o **status 200 OK** com os detalhes completos do filme
  E a página de detalhes deve exibir a sinopse, elenco, diretor e sessões disponíveis com seus horários, cinemas e preços

Cenário: Navegar para seleção de assentos a partir dos detalhes do filme (UI)
  Dado que sou um "Usuário" logado
  E estou na página de detalhes do filme "O Poderoso Chefão"
  E existem sessões disponíveis para este filme
  Quando eu clico em um horário de sessão disponível
  Então eu sou redirecionado para a página de seleção de assentos (`/sessions/:id/seats`) para aquela sessão específica

```
## Funcionalidade: Gerenciamento de Filmes (Administrador)
```
Cenário: Criar um novo filme com sucesso (UI e API)
  Dado que sou um "Administrador" logado
  Quando eu acesso o painel administrativo (`/admin`)
  E navego para a seção de "Gerenciamento de Filmes" (`/admin/movies`)
  E clico no botão "Adicionar Novo Filme"
  E preencho o formulário com dados válidos e únicos para um filme (ex: "Viagem Intergaláctica", "Ficção Científica", 150 min, etc.)
  E clico no botão "Salvar"
  Então uma requisição **POST** para `/api/v1/movies` deve ser enviada com os dados do filme
  E a **API** deve retornar o **status 201 Created**
  E a resposta da **API** deve conter os detalhes do filme recém-criado
  E o novo filme deve aparecer na lista de filmes no painel de administração da UI
  E uma mensagem de sucesso deve ser exibida na UI

Cenário: Editar um filme existente (UI e API)
  Dado que sou um "Administrador" logado
  E existe um filme "Filme para Edição" com o ID "filme_edicao_xyz" no sistema
  Quando eu acesso a seção de "Gerenciamento de Filmes" no painel administrativo
  E localizo o filme "Filme para Edição"
  E clico no ícone de "Editar" para este filme
  E altero o campo "Duração" para "145" minutos
  E clico no botão "Salvar Alterações"
  Então uma requisição **PUT** para `/api/v1/movies/filme_edicao_xyz` deve ser enviada com a duração atualizada
  E a **API** deve retornar o **status 200 OK**
  E a resposta da **API** deve conter os detalhes do filme atualizados
  E a lista de filmes na UI deve refletir a nova duração para "Filme para Edição"
  E uma mensagem de sucesso deve ser exibida na UI

Cenário: Excluir um filme (UI e API)
  Dado que sou um "Administrador" logado
  E existe um filme "Filme para Exclusão" com o ID "filme_del_abc" no sistema
  Quando eu acesso a seção de "Gerenciamento de Filmes" no painel administrativo
  E localizo o filme "Filme para Exclusão"
  E clico no ícone de "Excluir" para este filme
  E confirmo a ação de exclusão no diálogo de confirmação
  Então uma requisição **DELETE** para `/api/v1/movies/filme_del_abc` deve ser enviada
  E a **API** deve retornar o **status 204 No Content**
  E o filme não deve mais ser exibido na lista de filmes no painel de administração
  E uma mensagem de sucesso "Filme excluído" deve ser exibida na UI

Cenário: Tentar criar filme com dados inválidos (UI e API)
  Dado que sou um "Administrador" logado
  Quando eu acesso a seção de "Gerenciamento de Filmes" no painel administrativo
  E clico no botão "Adicionar Novo Filme"
  E preencho o formulário com um "Título" vazio
  E clico no botão "Salvar"
  Então a requisição **POST** para `/api/v1/movies` deve ser enviada
  E a **API** deve retornar o **status 400 Bad Request**
  E a resposta da **API** deve conter `success: false` e detalhes de erro de validação
  E uma mensagem de erro "Título é obrigatório" deve ser exibida na UI abaixo do campo Título

```
## Funcionalidade: Gerenciamento de Salas (Administrador)
```
Cenário: Criar uma nova sala de cinema (UI e API)
  Dado que sou um "Administrador" logado
  Quando eu acesso o painel administrativo (`/admin`)
  E navego para a seção de "Gerenciamento de Salas" (`/admin/theaters`)
  E clico no botão "Adicionar Nova Sala"
  E preencho o formulário com "Nome da Sala: Sala Platinum", "Localização: Andar Superior", "Capacidade: 90"
  E clico no botão "Salvar"
  Então uma requisição **POST** para `/api/v1/theaters` deve ser enviada com os dados da sala
  E a **API** deve retornar o **status 201 Created**
  E a resposta da **API** deve conter os detalhes da sala criada
  E a "Sala Platinum" deve aparecer na lista de salas no painel de administração da UI

Cenário: Tentar criar sala com capacidade inválida (UI e API)
  Dado que sou um "Administrador" logado
  Quando eu acesso a seção de "Gerenciamento de Salas" no painel administrativo
  E clico no botão "Adicionar Nova Sala"
  E preencho o "Nome da Sala: Sala Zero"
  E preencho a "Capacidade: 0"
  E clico no botão "Salvar"
  Então uma requisição **POST** para `/api/v1/theaters` deve ser enviada
  E a **API** deve retornar o **status 400 Bad Request**
  E a resposta da **API** deve conter uma mensagem de erro de validação para a capacidade
  E uma mensagem de erro "Capacidade deve ser maior que 0" deve ser exibida na UI
```
## Funcionalidade: Gerenciamento de Sessões (Administrador)
```
Cenário: Agendar uma nova sessão com sucesso (UI e API)
  Dado que sou um "Administrador" logado
  E que existe um filme "Vingadores" e uma sala "Sala VIP" no sistema
  Quando eu acesso a seção de "Gerenciamento de Sessões" no painel administrativo
  E clico no botão "Agendar Nova Sessão"
  E seleciono o filme "Vingadores" e a sala "Sala VIP"
  E defino a data e hora para uma data futura (ex: "2025-12-25 20:00")
  E defino o preço do ingresso para "25.00"
  E clico no botão "Criar Sessão"
  Então uma requisição **POST** para `/api/v1/sessions` deve ser enviada com os dados da sessão
  E a **API** deve retornar o **status 201 Created**
  E a resposta da **API** deve conter os detalhes da sessão agendada
  E a nova sessão deve aparecer na lista de sessões no painel de administração da UI

Cenário: Tentar agendar sessão com conflito de horário na mesma sala (UI e API)
  Dado que sou um "Administrador" logado
  E existe uma sessão agendada na "Sala 1" para "2025-07-01 18:00" a "20:00"
  Quando eu acesso a seção de "Gerenciamento de Sessões" no painel administrativo
  E clico no botão "Agendar Nova Sessão"
  E seleciono a "Sala 1" e tento agendar uma sessão que se sobrepõe ao horário existente (ex: "2025-07-01 19:00")
  E clico no botão "Criar Sessão"
  Então uma requisição **POST** para `/api/v1/sessions` deve ser enviada
  E a **API** deve retornar o **status 400 Bad Request**
  E a resposta da **API** deve conter uma mensagem de erro indicando conflito de horário
  E uma mensagem de erro "Conflito de horário na sala" deve ser exibida na UI

```
## Funcionalidade: Reserva de Assentos e Checkout
```
Cenário: Realizar uma reserva de assentos com sucesso (UI e API)
  Dado que sou um "Usuário" logado
  E que existe uma sessão para o filme "Avatar" com assentos disponíveis
  Quando eu acesso a página de seleção de assentos para esta sessão
  E seleciono 2 (dois) assentos disponíveis (ex: A1, A2)
  E o subtotal é exibido corretamente na UI (ex: R$ 40.00)
  E clico no botão "Continuar para Pagamento"
  Então eu sou redirecionado para a página de checkout
  E a página de checkout exibe o resumo da sessão e dos assentos selecionados
  Quando eu preencho os dados de pagamento com informações válidas (simulado: Cartão de Crédito)
  E clico no botão "Confirmar Reserva"
  Então uma requisição **POST** para `/api/v1/reservations` deve ser enviada com `sessionId`, `seatIds` e `paymentInfo`
  E a **API** deve retornar o **status 201 Created**
  E a resposta da **API** deve conter os detalhes da reserva confirmada e um `confirmationCode`
  E os assentos "A1" e "A2" devem ter seus status alterados para "reserved" na **API** da sessão
  E uma tela de confirmação de reserva com o código deve ser exibida na UI

Cenário: Tentar reservar assentos indisponíveis (UI e API)
  Dado que sou um "Usuário" logado
  E que existe uma sessão e os assentos "B1" e "B2" já estão reservados por outro usuário
  Quando eu acesso a página de seleção de assentos para esta sessão
  E os assentos "B1" e "B2" são exibidos como indisponíveis (cor diferente)
  Quando eu tento selecionar o assento "B1"
  Então o assento "B1" não deve ser selecionado na UI
  E uma mensagem de aviso "Assento indisponível" deve ser exibida
  E mesmo que eu tente prosseguir para o checkout com "B1" selecionado,
  Quando eu confirmo o pagamento
  Então a **API** deve retornar o **status 400 Bad Request** ou `SEAT_UNAVAILABLE`
  E uma mensagem de erro "Assentos selecionados não estão mais disponíveis" deve ser exibida na UI
```
## Funcionalidade: Gerenciamento de Reservas (Usuário e Administrador)
```
Cenário: Visualizar minhas reservas como usuário (UI e API)
  Dado que sou um "Usuário" logado
  E possuo reservas ativas no sistema
  Quando eu clico no link "Minhas Reservas" no Front-end
  Então uma requisição **GET** para `/api/v1/reservations/me` deve ser enviada com o token JWT
  E a **API** deve retornar o **status 200 OK** com a lista de minhas reservas
  E a lista de minhas reservas deve ser exibida na UI com os detalhes (filme, data, hora, cinema, assentos, status, pôster)

Cenário: Administrador visualiza todas as reservas (UI e API)
  Dado que sou um "Administrador" logado
  Quando eu acesso o painel administrativo (`/admin`)
  E navego para a seção de "Gerenciamento de Reservas" (`/admin/reservations`)
  Então uma requisição **GET** para `/api/v1/reservations` deve ser enviada com o token JWT do admin
  E a **API** deve retornar o **status 200 OK** com a lista de *todas* as reservas do sistema
  E a lista completa de reservas (incluindo reservas de outros usuários) deve ser exibida na UI
```
## Funcionalidade: Gerenciamento de Usuários (Administrador - API)
```
Cenário: Administrador busca um usuário por ID (API)
  Dado que sou um "Administrador" logado
  E que existe um usuário com o ID "user_test_api_id"
  Quando eu envio uma requisição **GET** para `/api/v1/users/user_test_api_id`
  Então a **API** deve retornar o **status 200 OK**
  E a resposta da **API** deve conter os detalhes do usuário com ID "user_test_api_id"

Cenário: Administrador tenta deletar um usuário inexistente (API)
  Dado que sou um "Administrador" logado
  Quando eu envio uma requisição **DELETE** para `/api/v1/users/usuario_inexistente_id`
  Então a **API** deve retornar o **status 404 Not Found**
  E a resposta da **API** deve conter `success: false` e uma mensagem de erro indicando que o recurso não foi encontrado
```
