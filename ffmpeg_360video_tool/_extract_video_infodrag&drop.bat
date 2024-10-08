@echo off
setlocal

rem Check if a video file was provided as an argument
if "%~1"=="" (
    echo Drag and drop a video file onto this script.
    pause
    exit /b
)

set "VIDEO_FILE=%~1"

rem Use ffmpeg to extract the information
set "INFO="
set "COMPRESSION="
set "RESOLUTION="
set "FPS="
set "BITRATE="

for /f "tokens=*" %%i in ('ffmpeg -i "%VIDEO_FILE%" 2^>^&1') do (
    echo %%i | findstr /C:"fps" > nul
    if not errorlevel 1 (
        set "INFO=%%i"
        goto :found
    )
)

echo Information not found.
goto :end

:found
rem Extract the information from the string
for /f "tokens=4,10,13,17 delims=, " %%a in ("%INFO%") do (
    set "COMPRESSION=%%a"
    set "RESOLUTION=%%b"
    set "FPS="%%c"
    set "BITRATE=%%d"
)

rem Output the extracted information
echo Compression: %COMPRESSION%
echo Resolution: %RESOLUTION% px
echo Framerate: %FPS% fps
echo Bitrate %BITRATE% kb/s

:end
pause




@REM FFPEG COMMAND
@REM ffmpeg -i video.mp4 2>&1 | findstr /R "fps"

@REM OUTPUT
@REM Stream #0:0[0x1](und): Video: h264 (High) (avc1 / 0x31637661), yuv420p(progressive), 1920x960, 3486 kb/s, 29.97 fps, 29.97 tbr, 360k tbn (default)

@REM TOKENS

@REM TOKENS
@REM 1. Stream
@REM 2.#0:0[0x1](und):
@REM 3. Video:
@REM 4. h264
@REM 5. (High)
@REM 6. (avc1
@REM 7. /
@REM 8. 0x31637661),
@REM 9. yuv420p(progressive),
@REM 10. 1920x960,
@REM 11. 3486
@REM 12. kb/s,
@REM 13. 29.97
@REM 14. fps,
@REM 15. 29.97
@REM 16. tbr,
@REM 17. 360k
@REM 18. tbn
@REM 19. (default)
