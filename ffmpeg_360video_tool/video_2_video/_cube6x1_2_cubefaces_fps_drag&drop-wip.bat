@echo off
setlocal enabledelayedexpansion

rem Controlla se è stato passato un argomento (il file video)
if "%~1"=="" (
    echo Errore: nessun file video specificato. Trascina e rilascia un file video su questo script.
    pause
    exit /b
)

rem Imposta la cartella corrente e il nome del file video
set input_folder=%~dp1
set input_video=%~nx1
set filename=%~n1

rem Crea la cartella di output se non esiste
set output_folder=%input_folder%videos_cubefaces
if not exist "%output_folder%" mkdir "%output_folder%"

rem Converte il video in 6 video separati (cubemap 6x1)
ffmpeg -r -i "%input_folder%%input_video%" -vf "crop=iw/6:ih:0:0" -c:a copy "%output_folder%\right.mp4"
ffmpeg -r -i "%input_folder%%input_video%" -vf "crop=iw/6:ih:iw/6:0" -c:a copy "%output_folder%\left.mp4"
ffmpeg -r -i "%input_folder%%input_video%" -vf "crop=iw/6:ih:iw/3:0" -c:a copy "%output_folder%\up.mp4"
ffmpeg -r -i "%input_folder%%input_video%" -vf "crop=iw/6:ih:iw/2:0" -c:a copy "%output_folder%\down.mp4"
ffmpeg -r -i "%input_folder%%input_video%" -vf "crop=iw/6:ih:iw/1.5:0" -c:a copy "%output_folder%\front.mp4"
ffmpeg -r -i "%input_folder%%input_video%" -vf "crop=iw/6:ih:iw/1:0" -c:a copy "%output_folder%\back.mp4"

echo Conversione completata.
pause
