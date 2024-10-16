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

rem Crea il nome del file di output con suffisso "_trim"
set output_video=%input_folder%%filename%_trim%extension%

rem Imposta i tempi di inizio e fine per il trimming (puoi modificarli)
set start_time=00:00:00
set end_time=00:00:10

rem Esegui il trimming del video con ffmpeg
ffmpeg -i "%input_folder%%input_video%" -ss %start_time% -to %end_time% -c copy -c:a copy "%output_video%"

echo Conversione completata. File salvato come "%output_video%"

rem pause
exit