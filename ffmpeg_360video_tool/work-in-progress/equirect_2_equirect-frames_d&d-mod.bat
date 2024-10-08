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

rem Crea la cartella di output per le immagini equirettangolari
set equirect_folder=%input_folder%%filename%_frames_equirect
if not exist "%equirect_folder%" mkdir "%equirect_folder%"

rem Estrai i frame ogni secondo in base all'FPS e salva nella cartella dei frame equirettangolari
echo Estrazione di un frame ogni %fps% secondi da "%input_video%"...
ffmpeg -i "%input_folder%%input_video%" -vf fps=%fps% "%equirect_folder%\frame%%06d_e.png"

rem Loop per verificare l'esistenza dei file ed eventualmente chiedere conferma per sovrascrivere
for %%f in ("%equirect_folder%\*.png") do (
    rem Imposta il nome base del frame
    set "frame_filename=%%~nf"

    rem Verifica se il file esiste già
    if exist "%%f" (
        echo Il file "%%f" esiste già.
        set /p overwrite=Vuoi sovrascriverlo? (S/N): 

        if /i "!overwrite!" neq "S" (
            echo Saltato "%%f".
            rem Salta la conversione e passa al prossimo frame
            rem Usare "continue" non funziona direttamente in batch, dobbiamo usare un if/else qui
            goto :skip_conversion
        )
    )

    rem Se l'utente conferma, procedi con la conversione
    echo Conversione del frame "%%f" in cubemap 6x1...
    @REM ffmpeg -i "%%f" -vf "v360=equirect:c6x1" "%cubemap_folder%\!frame_filename:_e=_c6x1!.png"

    :skip_conversion
)

echo Conversione completata. I file equirettangolari sono stati salvati in "%equirect_folder%".
pause

