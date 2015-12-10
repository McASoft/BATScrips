@echo off
::Esto es un proceso para recorrer todos los posibles colores que se
::pueden colocar en una ventana del CMD usando el comando "color".
::V1.1

title Test de colores

for %%a in (0 1 2 3 4 5 6 7 8 9 A B C D E F) do (
   for %%b in (0 1 2 3 4 5 6 7 8 9 A B C D E F) do (
      if not "%%a"=="%%b" (
         color %%a%%b
         echo Este es el color %%a%%b.
         echo.
         echo Pulse una tecla para poner otro color.
         pause>nul
         cls
      )
   )
)