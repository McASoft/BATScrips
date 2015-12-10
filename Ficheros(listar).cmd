:: Autor  : Alberto Millan
:: Version: 1.3
:: Crea un fichero "nombres.txt" con la lista de los ficheros locales dos veces.
::  Esta lista se encuentra alineada en el centro (con todos los ':' en la
::  misma columna). Esto es asi para facilitar su edicion desde herramientas
::  como notepad++ (ver "Editar->Modo de columna...").
:: Ejemplo:
::nombre fichero 1.txt:nombre fichero 1.txt
::        nombre 2.txt:nombre 2.txt
::   fichero num 3.txt:fichero num 3.txt

@ECHO OFF

SETLOCAL DisableDelayedExpansion

TITLE Listar ficheros
ECHO Creando el fichero "nombres.txt"...

SET nombresTMP=nombresTMP

:tmptmp
IF EXIST %nombresTMP%.txt (
    SET nombresTMP=%nombresTMP%TMP
    GOTO tmptmp
)

SET nombresTMP=%nombresTMP%.txt

IF EXIST nombres.txt DEL nombres.txt

DIR /b  > %nombresTMP%
SET n=0

::Deja en %n% el numero de caracteres de la cadena mas larga.
FOR /F "delims=:" %%A IN (%nombresTMP%) DO (
    SET fich=%%A
    SETLOCAL EnableDelayedExpansion
    SET fich=!fich:%%=_!
    CALL :length !fich:^&=_!
    IF !return! GTR !n! SET n=!return!
    for /D %%i in (!n!) do (if "!"=="" endlocal)& set "n=%%i"
)

FOR /F "delims=:" %%A IN (%nombresTMP%) DO (
    SET fich=%%A
    SET str1=%%A
    SET str2=%%A
    SETLOCAL EnableDelayedExpansion
    SET fich=!fich:%%=_!
    CALL :length !fich:^&=_!
    SET /a return = !return! + 1
    FOR /L %%B IN (!return!, 1, !n!) DO (
        SET str1= !str1!
    )
    ECHO !str1!:!str2!>> nombres.txt
    ENDLOCAL
)
DEL %nombresTMP%

ECHO Fin de la creacion.
GOTO :eof



:length
SETLOCAL DisableDelayedExpansion
IF "%*" == "" (
    SET return=0
    ENDLOCAL
    GOTO :eof
)

SET palabra=%*
:: %palabra: =_% Reemplaza los '^' por '_'
SET palabra=%palabra:^=_%
SET palabra=%palabra:"=_%
CALL :leng %palabra: =_%

ENDLOCAL & SET return=%return%
GOTO :eof

:leng
SET word=%*
SET /a return=0
:lengLoop
SET word=%word:~1%
SET /a return +=1
IF NOT DEFINED word (GOTO :eof)
GOTO lengLoop