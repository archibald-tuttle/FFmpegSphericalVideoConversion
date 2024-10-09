@echo off
setlocal enabledelayedexpansion

rem Controlla se è stato passato un argomento (il file video)
if "%~1"=="" (
    echo Errore: nessun file video specificato. Trascina e rilascia un file video su questo script.
    pause
    exit /b
)

rem Imposta la cartella corrente e il nome del file
set input_folder=%~dp1
set input_video=%~nx1
set filename=%~n1
set extension=%~x1

rem Richiedi l'FPS per l'estrazione dei frame
set /p fps=Inserisci il numero di frame per secondo (fps) per l'estrazione: 

rem Crea le cartelle di output per le immagini equirettangolari e cubemap 6x1
set output_folder=%input_folder%%filename%_frames
if not exist "%output_folder%" mkdir "%output_folder%"


rem Estrai i frame ogni secondo in base all'FPS e salva nella cartella dei frame equirettangolari
echo Estrazione di un frame ogni %fps% secondi da "%input_video%"...
ffmpeg -i "%input_folder%%input_video%" -vf fps=%fps% "%output_folder%\frame%%06d.png"

echo Conversion completed. All frame files have been saved to "%output_folder%".
pause

