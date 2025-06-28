*** Settings ***
Documentation     Este arquivo define fixtures e keywords para usuários do sistema.
...               Inclui usuários comuns e administradores, com dados válidos e inválidos para testes de autenticação e autorização.
...               Útil para cenários de login, permissões de acesso e criação de usuários duplicados.
...               Deve ser utilizado em conjunto com testes que validam rotas protegidas e fluxo de autenticação.

*** Variables ***
${VALID_USER}               {"name": "João Teste", "email": "joao@teste.com", "password": "senha123"}
${USER_DUPLICATE_EMAIL}     {"name": "Maria Teste", "email": "joao@teste.com", "password": "outrasenha"}
${USER_MISSING_PASSWORD}    {"name": "SemSenha", "email": "sem@senha.com"}
${USER_INVALID_EMAIL}       {"name": "Erro Email", "email": "naoéemail", "password": "senha123"}
