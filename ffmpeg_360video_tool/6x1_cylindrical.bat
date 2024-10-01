@echo off
setlocal enabledelayedexpansion

rem Imposta la cartella corrente
set input_folder=%~dp0
set output_folder=%input_folder%output_videos

rem Crea la cartella di output se non esiste
if not exist "%output_folder%" mkdir "%output_folder%"

rem Imposta il frame rate (puoi modificarlo se necessario)
set framerate=30

rem Cerca i file con estensione PNG o JPG
set file_pattern=frame0%%05d.png

rem Controlla se ci sono immagini nella cartella corrente
if not exist "%input_folder%frame000001.png" if not exist "%input_folder%frame000001.jpg" (
    echo Errore: nessuna immagine trovata nella cartella. Assicurati che i file siano in formato PNG o JPG.
    pause
    exit /b
)

rem Converte i frame cubici in equirttangolari
ffmpeg -r 30 -i frame0%05d.png -vf "v360=c6x1:cylindrical:h_fov=120:v_fov=45" -c:v libx264 -crf 18 -preset slow -r 30 cylindrical_120h45v.mp4

echo Conversione completata.
pause
