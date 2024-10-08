@echo off
setlocal enabledelayedexpansion

rem Imposta la cartella corrente e il file video
set input_folder=%~dp1
set input_video=%~nx1

rem Estrai il frame rate del video
for /f "tokens=2 delims=," %%a in ('ffprobe -v 0 -of csv=p=0 -select_streams v:0 -show_entries stream=r_frame_rate "%input_folder%%input_video%"') do set fps=%%a

rem Calcola il frame rate reale
for /f "tokens=1,2 delims=/" %%a in ("%fps%") do (
    set /a fps_real=%%a / %%b
)

echo Frame rate estratto: %fps_real% fps.
pause