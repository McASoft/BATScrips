::Autor: Alberto Millan Carrascosa
::Ejecuta un determinado comando dentro de HH:MM gracias al comando "AT".
::V1.2
::
:: NOTA: Si lo que quieres es un retardo, tambien existe el comando TIMEOUT.

@echo off
title Temporizador para tarea retardada.

::***********************************************************************
::**************************  ENTRADA DE DATOS  *************************
::***********************************************************************

::Realiza un pequeño control de errores.
::Para que fuera correcto del todo, tendria que verificar la ruta absoluta.

:mal
cls
echo Ponaga la RUTA ABSOLUTA y el comando que quieres que se ejecute.
echo EJ: C:\WINDOWS\system32\shutdown.exe
set /p comando=: 
if not exist %comando% (
   echo.
   echo.
   echo Para esa ruta no exite ese comando. Introducela de nuevo.
   pause > nul
   goto mal
)

echo.
echo ¨Cuantas horas tienen que pasar?
set /p horas=:
echo.
echo ¨Y cuantos minutos?
set /p minutos=:
echo.


::***********************************************************************
::************** SUMA LA HORA INTRODUCIDA A LA HORA ACTUAL **************
::***********************************************************************

::Aqui saca la hora y minutos actuales y los suma a las horas y minutos que introduce el usuario.
::He puesto el if, porque si se usa set /a con un numero empezado por "0" (por ej 05)
::este lo reconoce como un numero en octal, lo que daria problemas para las horas
::"08" y "09". De esta forma al usar el "0x" delante asume que el numero esta en exadecimal.

for /f "delims=: tokens=1,2" %%a in ('time /t') do (
   if %%a LSS 10 (set /a horas=%horas%+0x%%a) ELSE set /a horas+=%%a
   if %%b LSS 10 (set /a minutos=%minutos%+0x%%b) ELSE set /a minutos+=%%b
)

::Esto pasa todo las horas a minutos para hacer mas comodo el siguiente paso.
set /a tiempo=%horas%*60+%minutos%


::esto elimina todo lo que exceda de 24h hasta dejarlo en algo inferior a 24h, ya que el comando
::"AT" no admite tareas que empiecen apartir de la hora "24:00" (como es normal).
if %tiempo% GTR 1440 set /a tiempo-=(%tiempo%/1440)*1440

::El set no trabaja con decimales, por lo que podemos pasar de nuevo las horas y minutos a 2 variables
::sin demasiados problemas.
set /a horas=%tiempo%/60
set /a minutos=%tiempo%-%horas%*60


::***********************************************************************
::**** INTRODUCE LA TAREA Y LA NUEVA HORA EN LAS "TAREAS PROGRAMADAS" ***
::***********************************************************************

at %horas%:%minutos% %comando%
at
echo.
echo.
echo.
echo La operacion ha terminado.
pause > nul



