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
set output_folder=%input_folder%videos_cubefaces
if not exist "%output_folder%" mkdir "%output_folder%"

rem Ottieni la risoluzione orizzontale del video originale
for /f "tokens=1,2 delims=x" %%a in ('ffprobe -v error -select_streams v:0 -show_entries stream=width,height -of csv=p=0:s=x "%input_folder%%input_video%"') do (
    set width=%%a
    set height=%%b
)

rem Calcola la risoluzione quadrata per le facce (larghezza originale divisa per 4)
set /a face_size=%width%/4

rem FOV orizzontale e verticale di 90°
set fov=90

rem Estrai e salva le 6 facce (destra, sinistra, su, giù, fronte, retro) con proiezione rettilinea
ffmpeg -i "%input_folder%%input_video%" -vf "v360=input=equirect:output=flat:yaw=0:pitch=0:h_fov=%fov%:v_fov=%fov%,scale=%face_size%:%face_size%" "%output_folder%\front.mp4"
ffmpeg -i "%input_folder%%input_video%" -vf "v360=input=equirect:output=flat:yaw=90:pitch=0:h_fov=%fov%:v_fov=%fov%,scale=%face_size%:%face_size%" "%output_folder%\right.mp4"
ffmpeg -i "%input_folder%%input_video%" -vf "v360=input=equirect:output=flat:yaw=-90:pitch=0:h_fov=%fov%:v_fov=%fov%,scale=%face_size%:%face_size%" "%output_folder%\left.mp4"
ffmpeg -i "%input_folder%%input_video%" -vf "v360=input=equirect:output=flat:yaw=180:pitch=0:h_fov=%fov%:v_fov=%fov%,scale=%face_size%:%face_size%" "%output_folder%\back.mp4"
ffmpeg -i "%input_folder%%input_video%" -vf "v360=input=equirect:output=flat:yaw=0:pitch=90:h_fov=%fov%:v_fov=%fov%,scale=%face_size%:%face_size%" "%output_folder%\up.mp4"
ffmpeg -i "%input_folder%%input_video%" -vf "v360=input=equirect:output=flat:yaw=0:pitch=-90:h_fov=%fov%:v_fov=%fov%,scale=%face_size%:%face_size%" "%output_folder%\down.mp4"

echo Conversione completata.
pause
