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
set filename=%~n1
set extension=%~x1

rem Richiedi l'FPS per l'estrazione dei frame
set /p fpsin=Inserisci il numero di frame per secondo (fps-in) video in:
set /p fpsout=Inserisci il numero di frame per secondo (fps-out) video out:

rem Crea la cartella di output se non esiste
set output_folder=%input_folder%cube6x1
if not exist "%output_folder%" mkdir "%output_folder%"

@REM rem Imposta il frame rate (puoi modificarlo se necessario)
@REM set framerate=30

rem Converte il video in cubemap 6x1
ffmpeg -r %fpsin% -i "%input_folder%%input_video%" -vf "v360=equirect:c6x1" -r %fpsout% "%output_folder%\!filename!_cube6x1.mp4"

echo Conversione completata.
exit
