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

rem Converte i frame cubici in 6 video separati
ffmpeg -r %framerate% -i "%input_folder%frame0%%05d.png" -vf "crop=iw/6:ih:0:0" -c:a copy "%output_folder%\right.mp4"
ffmpeg -r %framerate% -i "%input_folder%frame0%%05d.png" -vf "crop=iw/6:ih:iw/6:0" -c:a copy "%output_folder%\left.mp4"
ffmpeg -r %framerate% -i "%input_folder%frame0%%05d.png" -vf "crop=iw/6:ih:iw/3:0" -c:a copy "%output_folder%\up.mp4"
ffmpeg -r %framerate% -i "%input_folder%frame0%%05d.png" -vf "crop=iw/6:ih:iw/2:0" -c:a copy "%output_folder%\down.mp4"
ffmpeg -r %framerate% -i "%input_folder%frame0%%05d.png" -vf "crop=iw/6:ih:iw/1.5:0" -c:a copy "%output_folder%\front.mp4"
ffmpeg -r %framerate% -i "%input_folder%frame0%%05d.png" -vf "crop=iw/6:ih:iw/1:0" -c:a copy "%output_folder%\back.mp4"

echo Conversione completata.
pause
