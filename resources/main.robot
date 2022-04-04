*** Settings ***
## 1.0.5
##########################################################################
#                                 Libraries                              #
##########################################################################

Library  SeleniumLibrary
Library  FakerLibrary  locale=pt_BR
Library  DebugLibrary
Library  RequestsLibrary
Library  OperatingSystem
Library  Collections
Library  DateTime
Library  String
Library  ArchiveLibrary

# Library  ./libs/Mailer.py  
# ...  username=xxx@gmail.com 
# ...  password=xxxxxx  
# # ...  to=xxx@gmail.com

##########################################################################
#                                 Resources                              #
##########################################################################

Variables  ../resources/environments/env.stefanini.yaml
##########################################################################
#                                 Keywords                               #
##########################################################################

Resource  ./keywords/login.robot

##########################################################################
#                                 Elementos                              #
##########################################################################

Resource  ./pages/pg_login.robot
    


*** Keywords ***
Abrir navegador
    Open Browser           browser=${Navegador.BROWSER}       options=add_experimental_option('excludeSwitches', ['enable-logging'])
    Maximize Browser Window

Fechar navegador
    Close Browser