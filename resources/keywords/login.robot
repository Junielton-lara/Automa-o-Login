*** Settings ***
Resource  ../main.robot

Library    pabot.PabotLib


*** Keywords ***
#Validar elementos da tela

Dado que acesso a tela de login
    Go To    ${link.base}
    Capture Page Screenshot
    
Quando a tela e carregada   
    Run Keyword        Wait Until Page Contains    Para realizar o cadastro de um usuário, insira dados válidos no formulário e acione a opção Cadastrar :)
    Capture Page Screenshot

Entao devera ter os componetes
    Wait Until Element Is Visible    ${Login.name}
    Wait Until Element Is Visible    ${Login.email}
    Wait Until Element Is Visible    ${Login.password}
    Wait Until Element Is Visible    ${Login.btn_registrar}
    Capture Page Screenshot

#Validar nome incompleto
E informo o apenas o primeiro nome
    Input Text    ${Login.name}   ${nome_invalido}
E preencho dados de E-MAIL
    Input Text    ${Login.email}   ${email_valido}
E senha
    Input Text    ${Login.password}   ${senha_valida}
E cicar em registrar
    Click Button    ${Login.btn_registrar}

Então devera retornar a mensagem "Por favor, insira um nome completo"
    Wait Until Element Contains    ${Msg_error.nome_incompleto}   Por favor, insira um nome completo. 
    Capture Page Screenshot
    
#Validar email invalido
E informo um email invalido
    Input Text    ${Login.email}  ${email_invalido}

E preencho dados de nome
    Input Text    ${Login.name}    ${nome_valido}

Então devera retornar a mensagem "Por favor, insira um e-mail válido."
    Wait Until Element Contains    ${Msg_error.email_invalido}     Por favor, insira um e-mail válido.    
    Capture Page Screenshot

#Validar senha invalida
E senha invalida
    Input Text    ${Login.password}   ${senha_invalida} 

Então devera retornar a mensagem "A senha deve conter ao menos 8 caracteres." 
    Wait Until Element Contains    ${Msg_error.senha_invalida}   A senha deve conter ao menos 8 caracteres.
    Capture Page Screenshot

#Validar user cadastrado com sucesso
Então a pagina devera conter "Usuários cadastrados"
    Wait Until Element Contains    ${Cadastros.Inf_cad_ok}   Usuários cadastrados
    Capture Page Screenshot

E os dados cadastrais do user
    Wait Until Element Contains    ${Cadastros.Grid_name}       ${nome_valido} 
    Wait Until Element Contains    ${Cadastros.Grid_email}      ${email_valido} 
    Capture Page Screenshot

#Validar exclusão de user
E Clicar em excluir
    Click Element    ${Cadastros.btn_excluir}
    Capture Page Screenshot

Então o user devera ser excluido com sucesso
    Wait Until Element Is Not Visible    ${Cadastros.Grid_name}     timeout=None
    Capture Page Screenshot