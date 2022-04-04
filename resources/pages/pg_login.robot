*** Settings ***
Documentation        Aqui estarão presentes todas as variáveis/elementos da tela Home

*** Variables ***

&{Login}
#Elementos tela de login
...     name=name
...     email=email
...     password=password
...     btn_registrar=register

&{Msg_error}
#Elentos de mensagems de erro
...     nome_incompleto=xpath=//form/div/p
...     email_invalido=xpath=//div[2]/p
...     senha_invalida=xpath=//div[3]/p

&{Cadastros}
#Elementos apos cadastros user
...     Inf_cad_ok=xpath=//h2[2]
...     Grid_name=tdUserName1
...     Grid_email=tdUserEmail1
...     btn_excluir=removeUser1