*** Settings ***
*** Variables ***
${text}   Elo
*** Test Cases ***
pass text to the console
    Log To Console    hej

pass var to the console
    Log To Console    ${text}
*** Keyword ***
