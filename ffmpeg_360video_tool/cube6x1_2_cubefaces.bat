@echo off
setlocal enabledelayedexpansion

rem Imposta la cartella corrente
set input_folder=%~dp0
set output_folder=%input_folder%output_videos_faces

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
ffmpeg -r %framerate% -i "%input_folder%%input_video%" -vf "crop=iw/6:ih:0:0" -c:a copy "%output_folder%\right.mp4"
ffmpeg -r %framerate% -i "%input_folder%%input_video%" -vf "crop=iw/6:ih:iw/6:0" -c:a copy "%output_folder%\left.mp4"
ffmpeg -r %framerate% -i "%input_folder%%input_video%" -vf "crop=iw/6:ih:iw/3:0" -c:a copy "%output_folder%\up.mp4"
ffmpeg -r %framerate% -i "%input_folder%%input_video%" -vf "crop=iw/6:ih:iw/2:0" -c:a copy "%output_folder%\down.mp4"
ffmpeg -r %framerate% -i "%input_folder%%input_video%" -vf "crop=iw/6:ih:iw/1.5:0" -c:a copy "%output_folder%\front.mp4"
ffmpeg -r %framerate% -i "%input_folder%%input_video%" -vf "crop=iw/6:ih:iw/1:0" -c:a copy "%output_folder%\back.mp4"

echo Conversione completata.
pause

