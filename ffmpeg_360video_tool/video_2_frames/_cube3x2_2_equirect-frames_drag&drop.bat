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

rem Crea le cartelle di output per le immagini equirettangolari
set cube3x2_folder=%input_folder%%filename%_frames_equirect
if not exist "%cube3x2_folder%" mkdir "%cube3x2_folder%"


rem Estrai i frame ogni secondo in base all'FPS e salva nella cartella dei frame equirettangolari
echo Estrazione di un frame ogni %fps% secondi da "%input_video%"...
ffmpeg -i "%input_folder%%input_video%" -vf "v360=c3x2:equirect" fps=%fps% "%cube3x2_folder%\frame%%06d_e.png"

echo Conversion completed. Equirectangular files have been saved to "%cube3x2_folder%".
pause

