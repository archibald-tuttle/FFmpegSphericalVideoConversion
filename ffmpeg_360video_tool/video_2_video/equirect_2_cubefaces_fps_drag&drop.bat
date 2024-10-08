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
set "INFO="

rem Crea la cartella di output se non esiste
set output_folder=%input_folder%videos_cubefaces
if not exist "%output_folder%" mkdir "%output_folder%"

rem Estrai la risoluzione del video utilizzando ffmpeg
for /f "tokens=*" %%i in ('ffmpeg -i "%input_video%" 2^>^&1') do (
    echo %%i | findstr /C:"Video: " > nul
    if not errorlevel 1 (
        set "INFO=%%i"
        goto :found
    )
)

echo Informazioni non trovate.
goto :end

:found
rem Estrai le informazioni della risoluzione dalla stringa (esempio 1920x1080)
for /f "tokens=10 delims=, " %%a in ("%INFO%") do (
   for /f "tokens=1,2 delims=x" %%b in ("%%a") do (
       set width=%%b
       set height=%%c
   )

for /f "tokens=15 delims=, " %%a in ("%INFO%") do (
    set "FPS=%%a"
)
)

rem Richiedi l'FPS per l'estrazione dei frame (se vuoti usa il frame rate estratto)
set /p fpsin=Inserisci il numero di frame per secondo (fps-in) video in [Predefinito: %FPS%]: 
if "%fpsin%"=="" set fpsin=%FPS%

set /p fpsout=Inserisci il numero di frame per secondo (fps-out) video out [Predefinito: %FPS%]: 
if "%fpsout%"=="" set fpsout=%FPS%

rem Calcola la risoluzione quadrata per le facce (larghezza originale divisa per 4)
set /a face_size=%width%/4

rem FOV orizzontale e verticale di 90°
set fov=90

rem Estrai e salva le 6 facce (destra, sinistra, su, giù, fronte, retro) con proiezione rettilinea
ffmpeg -r %fpsin% -i "%input_folder%%input_video%" -vf "v360=input=equirect:output=flat:yaw=0:pitch=0:h_fov=%fov%:v_fov=%fov%,scale=%face_size%:%face_size%" -an -r %fpsout% "%output_folder%\!filename!_f.mp4"
ffmpeg -r %fpsin% -i "%input_folder%%input_video%" -vf "v360=input=equirect:output=flat:yaw=90:pitch=0:h_fov=%fov%:v_fov=%fov%,scale=%face_size%:%face_size%" -an -r %fpsout% "%output_folder%\!filename!_r.mp4"
ffmpeg -r %fpsin% -i "%input_folder%%input_video%" -vf "v360=input=equirect:output=flat:yaw=-90:pitch=0:h_fov=%fov%:v_fov=%fov%,scale=%face_size%:%face_size%" -an -r %fpsout% "%output_folder%\!filename!_l.mp4"
ffmpeg -r %fpsin% -i "%input_folder%%input_video%" -vf "v360=input=equirect:output=flat:yaw=180:pitch=0:h_fov=%fov%:v_fov=%fov%,scale=%face_size%:%face_size%" -an -r %fpsout% "%output_folder%\!filename!_b.mp4"
ffmpeg -r %fpsin% -i "%input_folder%%input_video%" -vf "v360=input=equirect:output=flat:yaw=0:pitch=90:h_fov=%fov%:v_fov=%fov%,scale=%face_size%:%face_size%" -an -r %fpsout% "%output_folder%\!filename!_u.mp4"
ffmpeg -r %fpsin% -i "%input_folder%%input_video%" -vf "v360=input=equirect:output=flat:yaw=0:pitch=-90:h_fov=%fov%:v_fov=%fov%,scale=%face_size%:%face_size%" -an -r %fpsout% "%output_folder%\!filename!_d.mp4"

echo Conversione completata.
pause
