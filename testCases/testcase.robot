*** Settings ***
Library                SSHLibrary
Library                mylibrary.py
Library                Impansible
Library                Collections
Library                SeleniumLibrary

*** Variables ***
${text}                Elo
${x}
${HOST}                localhost
${USERNAME}            tester
${PASSWORD}            tester

${browser}             firefox
${login}               testerwsb_t1
${pass}                adam1234
${wrong_pass}          janusz1234
${login_field}         //*[@id='login']
${pass_field}          //*[@id='password']
${link}                https://www.poczta.wp.pl
${submit_button}       //*[@id="btnSubmit"]
${odebrane_section}    Odebrane
${logout_button}       //*[@id="Logout-Button"]
${message_for_incorrect_password}   Niestety podany login lub hasło jest błędne.

*** Test Cases ***
pass text to the console
    Log To Console     Hej

pass var to the console
    Log To Console    ${text}

pass var by keyword to the console
    Show text   Hello   World

pass var by console to the console
    Log To Console    ${x}

Login to remote machine
    otwarcie polaczenia do komputera
    wprowadzenie uzytkownika i hasla
    sprawdzenie komendy uname
    zamkniecia polaczenia

# Wrong Login to remote machine
#    otwarcie polaczenia do komputera
#    wprowadzenie uzytkownika i hasla
#    sprawdzenie komendy uname
#    zamkniecia polaczenia

Compare two strings
      ${result}=   join two strings   hello    world
      Should be equal   ${result}     hello world

Add two numbers
      ${result}=   add two numbers   5    4
      Should be equal   ${result}     9.0

Check data in dictionary
      ${setup_result}=   Setup
      ${facts}=   Get From Dictionary   ${setup_result}   ansible_facts
      ${hostname}=   Get From Dictionary   ${facts}   ansible_hostname
      Should Contain   ${hostname}    tester-m
      ${distribution}=   Get From Dictionary   ${facts}   ansible_distribution
      Should Contain   ${distribution}    Ubuntu

Login to poczta wp
      przejdz do strony poczta
      wpisz nazwe uzytkownika
      wpisz haslo uzytkownika
      kliknij przycisk zaloguj
      sprawdz czy jestes zalogowany
      wyloguj sie

Incorrect Login to poczta wp
      przejdz do strony poczta
      wpisz nazwe uzytkownika
      wpisz zle haslo uzytkownika
      kliknij przycisk zaloguj
      sprawdz informacje o blednym logowaniu
      zamknij przegldarke

*** Keyword ***
Show text
    [Arguments]   ${text}   ${next}
    Log To Console    ${text}   ${next}

otwarcie polaczenia do komputera
    Open Connection   ${host}

wprowadzenie uzytkownika i hasla
    Login     ${USERNAME}        ${PASSWORD}

sprawdzenie komendy uname
    ${remoteControl} =   Execute Command    uname -a
    Should Contain    ${remoteControl}    GNU/Linux

zamkniecia polaczenia
    Close All Connections

przejdz do strony poczta
    Open Browser    ${link}   ${browser}

wpisz nazwe uzytkownika
    Input text    ${login_field}    ${login}

wpisz haslo uzytkownika
    Input text    ${pass_field}    ${pass}

kliknij przycisk zaloguj
    Click element   ${submit_button}

sprawdz czy jestes zalogowany
    Sleep   5
    Page Should Contain  ${odebrane_section}

wyloguj sie
    Click element   ${logout_button}
    Sleep   5
    Close All Browsers

zamknij przegldarke
    Close All Browsers

wpisz zle haslo uzytkownika
    Input text    ${pass_field}    ${wrong_pass}

sprawdz informacje o blednym logowaniu
    Sleep   5
    Page Should Contain  ${message_for_incorrect_password}
