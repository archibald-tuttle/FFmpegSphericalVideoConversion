@echo off
setlocal enabledelayedexpansion

rem Controlla se è stato passato un argomento (il file video)
if "%~1"=="" (
    echo Errore: nessun file video specificato. Trascina e rilascia un file video su questo script.
    pause
    exit /b
)

rem Imposta la cartella corrente
set input_folder=%~dp1
set input_video=%~nx1

rem Crea la cartella di output se non esiste
set output_folder=%input_folder%videos_cube6x1
if not exist "%output_folder%" mkdir "%output_folder%"

rem Imposta il frame rate (puoi modificarlo se necessario)
set framerate=30

rem Converte il video in cubemap 6x1
ffmpeg -r %framerate% -i "%input_folder%%input_video%" -vf "v360=equirect:c6x1" "%output_folder%\cube6x1.mp4"

echo Conversione completata.
pause
