@echo off
setlocal enabledelayedexpansion

rem Check if a video file is provided as an argument
if "%~1"=="" (
    echo Error: No video file specified. Drag and drop a video file onto this script.
    pause
    exit /b
)

rem Set the input folder and the video file
set input_folder=%~dp1
set input_video=%~nx1

rem Debug: Display the input video path
echo Input video path: "%input_folder%%input_video%"
@echo off
setlocal enabledelayedexpansion

rem Controlla se è stato passato un argomento (il file video)
if "%~1"=="" (
    echo Errore: nessun file video specificato. Trascina e rilascia un file video su questo script.
    pause
    exit /b
)

rem Imposta la cartella corrente e il file video
set input_folder=%~dp1
set input_video=%~nx1
set filename=%~n1
set extension=%~x1
set "FRAME_RATE="
set "FORMAT="
set "RESOLUTION="
set "BITRATE="

rem Estrai il frame rate del video utilizzando ffprobe
for /f "tokens=*" %%i in ('ffmpeg -i "%input_video%" 2^>^&1') do (
    echo %%i | findstr /C:"fps" > nul
    if not errorlevel 1 (
        set "FRAME_RATE=%%i"
        goto :found
    )
)

echo Informazioni non trovate.
goto :end

:found
rem Estrae le informazioni dalla stringa
for /f "tokens=15,4,10,17 delims= " %%a in ("%FRAME_RATE%") do (
    set "FPS=%%a"
    set "FORMAT=%%a"
    set "RESOLUTION=%%b"
    set "BITRATE=%%c"
)

rem Richiedi l'FPS per l'estrazione dei frame (se vuoti usa il frame rate estratto)
set /p fpsin=Inserisci il numero di frame per secondo (fps-in) video in [Predefinito: %BITRATE%]: 
if "%fpsin%"=="" set fpsin=%BITRATE%

set /p fpsout=Inserisci il numero di frame per secondo (fps-out) video out [Predefinito: %BITRATE%]: 
if "%fpsout%"=="" set fpsout=%BITRATE%

rem Crea la cartella di output se non esiste
set output_folder=%input_folder%cube6x1
if not exist "%output_folder%" mkdir "%output_folder%"

rem Converte il video in cubemap 6x1 con i frame rate specificati o estratti
ffmpeg -r %fpsin% -i "%input_folder%%input_video%" -vf "v360=equirect:c6x1" -r %fpsout% "%output_folder%\!filename!_cube6x1.mp4"

echo Conversione completata.
pause
exit
