*** Settings ***
Library                SSHLibrary
Library                Impansible
Library                Collections
Library                SeleniumLibrary

*** Variables ***

${browser}             firefox
${login}               testerwsb_t1
${pass}                adam1234
${wrong_pass}          janusz1234
${login_field}         //*[@id='login']
${pass_field}          //*[@id='password']
${mypage}		https://www.poczta.wp.pl
${submit_button}       //*[@id="btnSubmit"]
${odebrane_section}    Odebrane
${logout_button}       //*[@id="Logout-Button"]
${message_for_incorrect_password}   Niestety podany login lub hasło jest błędne.

*** Keywords ***
${page} setup
	Open Browser    ${mypage}   ${browser}
	Log to console  Wchodze na strone ${page}

${page} teardown
	Log to console  Wychodze ze strony ${page}

credentials
	Log to console  wyslalem dobre cred
	[Return]  user  pass

bad credentials
	Log to console  wyslalem zle cred
	[Return]  baduser  badpass

logged
	Log to console  szukaj Odebrane
	[Return]  Odebrane


Enter Credentials
	[Arguments]  ${user}  ${pass}
	Log to console  uzylem cred ${user} ${pass}

webpage check
	[Arguments]  ${slowo}
	${result}=	Run Keyword and return status		Page Should Contain		${slowo}
	Log to console  szukalem slowa ${slowo}
	[Return]  ${result}
