@echo off
setlocal enabledelayedexpansion

rem Imposta la cartella corrente
set input_folder=%~dp0
set output_folder=%input_folder%output_videos_cube3x2

rem Crea la cartella di output se non esiste
if not exist "%output_folder%" mkdir "%output_folder%"

rem Richiedi il nome del file video all'utente
set /p input_video=Inserisci il nome del file video (esempio: video.mp4): 

rem Controlla se il file video esiste nella cartella corrente
if not exist "%input_folder%%input_video%" (
    echo Errore: file video non trovato. Assicurati che il file sia presente nella cartella.
    pause
    exit /b
)

rem Imposta il frame rate (puoi modificarlo se necessario)
set framerate=30

rem Converte il video in 6 video separati (cubemap 6x1)
ffmpeg -r %framerate% -i "%input_folder%%input_video%" -vf "v360=equirect:c3x2" cube3x2.mp4"

echo Conversione completata.
pause

