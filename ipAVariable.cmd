@echo off
setlocal ENABLEDELAYEDEXPANSION

call :getIP
set i=0
:while
IF NOT "!IP%i%!" == "" (
	echo IPv4 %i%: !IP%i%!
	set /A i=%i%+1
	goto while
)
pause > nul
goto :eof


::Funcion getIP
::  Devuelve las IPs v4 en las variables consecuivas %IPn%
::    donde n = [0 .. NUMERO_IPS - 1].
:getIP
set i=0
for /f "delims={}," %%A in ('wmic nicconfig get ipaddress ^| findstr [0-9]*\.[0-9]*\.[0-9]*\.[0-9]*') do (
	set IP!i!=%%~A
	set /A i=%i%+1
)
endlocal