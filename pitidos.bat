@echo off
::Autor: Alberto Millan Carrascosa.
::V1.3
::Los pitidos se logran mediante
::Las teclas "Ctrl+G" (codigo 28).

title pitidos

set /p pitidos=¨Cuantos pitidos desea escuchar? 
for /l %%a in (1,1,%pitidos%) do (
    timeout /NOBREAK 1 > nul
    echo 
)
