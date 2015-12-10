:: Autor  : Alberto Millan
:: Version: 1.1
:: Renombra todos los ficheros de una carpeta segun los criterios de un fichero
::  "nombres.txt".
:: Este script esta pensado para ser usado junto con "Ficheros(listar).cmd" que
::  creara la lista para posteriormente ser editada.
::
:: IMPORTANTE: Este script ademas de renombrar los ficheros, borra los 2 scripts
::  "Ficheros(renombrar).cmd" y "Ficheros(listar).cmd" ademas del fichero
::  "nombres.txt". Es importante no modificar el nombre de estos dos ultimos
::  ficheros.
::
:: El formato que tiene que seguir el fichero "nombres.txt" es el siguiente:
::  NOMBRE_ORIGINAL:NOMBRE_NUEVO

:: Ejemplo:
::  fichero Original.mp3:fichero Nuevo1.mp3
::      fichero Or 2.mp3:fichero 2.mp3
::
@ECHO OFF
setlocal DisableDelayedExpansion

TITLE Renombrar ficheros
ECHO Renombrando los fichero...

FOR /F "tokens=1,2 delims=:" %%A IN (nombres.txt) DO (
    for /f "tokens=* delims= " %%B in ("%%A") do set str1=%%B
    set str2=%%B
    setlocal EnableDelayedExpansion
    rename "!str1!" "!str2!"
    ENDLOCAL
)

del nombres.txt
del Ficheros(listar).cmd
CALL ECHO Fin del renombre.
del %0