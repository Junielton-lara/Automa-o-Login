*** Settings ***
Resource  ../resources/main.robot

Suite Setup      Abrir navegador
Suite Teardown   Fechar Navegador


*** Test Cases ***

Validar elementos da tela
    Dado que acesso a tela de login
    Quando a tela e carregada
    Entao devera ter os componetes
    

Validar nome incompleto
    Dado que acesso a tela de login
    Quando a tela e carregada
    E informo o apenas o primeiro nome
    E preencho dados de E-MAIL
    E senha
    E cicar em registrar
    Então devera retornar a mensagem "Por favor, insira um nome completo"


Validar email invalido
    Dado que acesso a tela de login
    Quando a tela e carregada
    E informo um email invalido
    E preencho dados de nome
    E senha
    E cicar em registrar
    Então devera retornar a mensagem "Por favor, insira um e-mail válido." 

Validar senha invalida
    Dado que acesso a tela de login
    Quando a tela e carregada
    E preencho dados de E-MAIL
    E preencho dados de nome
    E senha invalida
    E cicar em registrar
    Então devera retornar a mensagem "A senha deve conter ao menos 8 caracteres." 


Validar user cadastrado com sucesso
    Dado que acesso a tela de login
    Quando a tela e carregada
    E preencho dados de E-MAIL
    E preencho dados de nome
    E senha
    E cicar em registrar
    Então a pagina devera conter "Usuários cadastrados"
    E os dados cadastrais do user

Validar exclusão de user
    Dado que acesso a tela de login
    Quando a tela e carregada
    E preencho dados de E-MAIL
    E preencho dados de nome
    E senha
    E cicar em registrar
    E Clicar em excluir
    Então o user devera ser excluido com sucesso