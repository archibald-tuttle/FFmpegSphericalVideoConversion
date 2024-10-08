@echo off
setlocal enabledelayedexpansion

rem Imposta la cartella corrente come input folder
set input_folder=%~dp0
set output_folder=%input_folder%cubemaps

rem Crea la cartella di output "cubemaps" se non esiste
if not exist "%output_folder%" mkdir "%output_folder%"

rem Estensioni supportate
set extensions=*.png *.jpg *.jpeg

rem Scansiona i file immagine nella cartella corrente
for %%f in (%extensions%) do (
    rem Estrai solo il nome del file senza estensione
    set filename=%%~nf
    
    rem Salva il cubemap 6x1 direttamente nella cartella "cubemaps" con il suffisso -cube6x1
    ffmpeg -i "%%f" -vf "v360=equirect:c6x1" "%output_folder%\!filename!-cube6x1.png"
    
    rem Crea una sottocartella per ogni immagine convertita dentro "cubemaps" per le singole facce
    set image_output_folder=%output_folder%\!filename!-cubefaces
    if not exist "!image_output_folder!" mkdir "!image_output_folder!"
    
    rem Estrai e salva ogni faccia (destra, sinistra, su, giù, fronte, retro) con i nomi originali e suffissi
    ffmpeg -i "%output_folder%\!filename!-cube6x1.png" -vf "crop=iw/6:ih:0:0" "!image_output_folder!\!filename!-right.png"
    ffmpeg -i "%output_folder%\!filename!-cube6x1.png" -vf "crop=iw/6:ih:iw/6:0" "!image_output_folder!\!filename!-left.png"
    ffmpeg -i "%output_folder%\!filename!-cube6x1.png" -vf "crop=iw/6:ih:iw/3:0" "!image_output_folder!\!filename!-up.png"
    ffmpeg -i "%output_folder%\!filename!-cube6x1.png" -vf "crop=iw/6:ih:iw/2:0" "!image_output_folder!\!filename!-down.png"
    ffmpeg -i "%output_folder%\!filename!-cube6x1.png" -vf "crop=iw/6:ih:iw/1.5:0" "!image_output_folder!\!filename!-front.png"
    ffmpeg -i "%output_folder%\!filename!-cube6x1.png" -vf "crop=iw/6:ih:iw/1:0" "!image_output_folder!\!filename!-back.png"
)

echo Conversione completata.
pause
