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
set equirect_folder=%input_folder%%filename%_frames_equirect
set cubemap_folder=%input_folder%%filename%_frames_cube6x1
if not exist "%equirect_folder%" mkdir "%equirect_folder%"
if not exist "%cubemap_folder%" mkdir "%cubemap_folder%"

rem Crea la cartella di output per le facce cubemap
set output_folder=%input_folder%%filename%_cubefaces
if not exist "%output_folder%" mkdir "%output_folder%"

rem Estrai i frame ogni secondo in base all'FPS e salva nella cartella dei frame equirettangolari
echo Estrazione di un frame ogni %fps% secondi da "%input_video%"...
ffmpeg -i "%input_folder%%input_video%" -vf fps=%fps% "%equirect_folder%\frame%%06d_e.png"

rem Conversione dei frame estratti in cubemap e separazione delle facce
for %%f in ("%equirect_folder%\*.png") do (
    rem Imposta il nome base del frame
    set frame_filename=%%~nf

    rem Converte il frame equirettangolare in una cubemap 6x1 e salva nella cartella cubemap
    echo Conversione del frame "%%f" in cubemap 6x1...
    ffmpeg -i "%%f" -vf "v360=equirect:c6x1" "%cubemap_folder%\!frame_filename:_e=_c6x1!.png"

    rem Crea una sottocartella per ogni frame per salvare le sei facce
    set cubeface_folder=%output_folder%\!frame_filename:_e=!
    if not exist "!cubeface_folder!" mkdir "!cubeface_folder!"

    rem Estrai e salva le sei facce del cubemap con il nome del frame originale e i suffissi
    ffmpeg -i "%cubemap_folder%\!frame_filename:_e=_c6x1!.png" -vf "crop=iw/6:ih:0:0" "!cubeface_folder!\!frame_filename:_e=!_r.png"
    ffmpeg -i "%cubemap_folder%\!frame_filename:_e=_c6x1!.png" -vf "crop=iw/6:ih:iw/6:0" "!cubeface_folder!\!frame_filename:_e=!_l.png"
    ffmpeg -i "%cubemap_folder%\!frame_filename:_e=_c6x1!.png" -vf "crop=iw/6:ih:iw/3:0" "!cubeface_folder!\!frame_filename:_e=!_u.png"
    ffmpeg -i "%cubemap_folder%\!frame_filename:_e=_c6x1!.png" -vf "crop=iw/6:ih:iw/2:0" "!cubeface_folder!\!frame_filename:_e=!_d.png"
    ffmpeg -i "%cubemap_folder%\!frame_filename:_e=_c6x1!.png" -vf "crop=iw/6:ih:iw/1.5:0" "!cubeface_folder!\!frame_filename:_e=!_f.png"
    ffmpeg -i "%cubemap_folder%\!frame_filename:_e=_c6x1!.png" -vf "crop=iw/6:ih:iw/1:0" "!cubeface_folder!\!frame_filename:_e=!_b.png"

    echo Frame "%%f" convertito con successo.
)

echo Conversione completata. I file equirettangolari sono stati salvati in "%equirect_folder%" e le cubemap 6x1 in "%cubemap_folder%".
pause

