::Borra de forma recursiva todas las carpetas vacias partiendo desde la ruta
::  donde se encuentra el script.

@echo off


cd %~dp0

FOR /f "delims=" %%i in ('dir /s /b /ad ^| sort /r') DO (
  rd "%%i" 2> NUL
  IF NOT EXIST %%i echo "%%i"
)
echo.
echo No hay mas carpetas vacias.
pause > NUL