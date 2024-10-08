@echo off
setlocal enabledelayedexpansion

rem Controlla se è stato passato un argomento (il file video)
if "%~1"=="" (
    echo Error: No video file specified. Drag and drop a video file to this script.
    pause
    exit /b
)

rem Imposta la cartella corrente e il nome del file
set input_folder=%~dp1
set input_video=%~nx1
set filename=%~n1
set extension=%~x1

rem Crea il nome del file di output con suffisso "_trimed"
set output_video=%input_folder%%filename%_trim%extension%

rem Richiedi i tempi di inizio e fine per il trimming
set /p start_time=Enter the start time (formato 00:00:00 o 00:00:00:000): 
set /p end_time=Enter the end time (formato 00:00:00 o 00:00:00:000):

rem Esegui il trimming del video con ffmpeg
ffmpeg -i "%input_folder%%input_video%" -ss %start_time% -to %end_time% -c copy -c:a copy "%output_video%"

echo Conversion completed. File saved as "%output_video%"

rem pause
exit