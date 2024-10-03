@echo off
setlocal enabledelayedexpansion

rem Imposta la cartella corrente come input folder
set input_folder=%~dp0
set output_folder=%input_folder%cubemap3x2

rem Crea la cartella di output "cubemap" se non esiste
if not exist "%output_folder%" mkdir "%output_folder%"

rem Estensioni supportate
set extensions=*.png *.jpg *.jpeg

rem Scansiona i file immagine nella cartella corrente
for %%f in (%extensions%) do (
    rem Estrai solo il nome del file senza estensione
    set filename=%%~nf
    
    rem Salva il cubemap 6x1 direttamente nella cartella "cubemaps" con il suffisso -cube6x1
    ffmpeg -i "%%f" -vf "v360=equirect:c3x2" "%output_folder%\!filename!-cube3x2.png"
)

echo Conversione completata.
pause
