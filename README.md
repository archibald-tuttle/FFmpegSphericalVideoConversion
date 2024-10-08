# FFmpegSphericalVideoConversion
Transform video projections such as cubemap, equirectangular, and more.

This repository provides a set of scripts that simplify the process of converting and editing 360° and spherical video formats using FFmpeg. Actually it doesn't cover all the combination. The scripts are open, it will be easy to custumize starting from the examples.

Whether you're working with 360 panoramic projection as equirectangular or cubemap, and you need to convert projections, these tools are designed for easy integration into your workflow. 

Ideal for anyone working with VR, Immersive Media, Spherical Photogrammetry.

Features:
1 - Convert standard panoramic images sequence and video 
2 - Batch processing for image sequences
3 - Split and combine panoramic formats
4 - No quality loss during processing
5 - Customizable frame rates and video output settings
6 - Simple integration into workflows using FFmpeg

Feel free to customize any part of the text further to suit your preferences!

--------------------------------------------------
Install FFmpeg and ensuring FFmpeg Works Correctly (OS Windows)

For the conversion tools to work correctly, FFmpeg must be installed on your system, and the installation path must be included in the Windows environment variables (PATH).

Install FFmpeg
(1) If FFmpeg is not installed, you can download it from the official site: https://ffmpeg.org/download.html.
Follow the instructions for your platform (Windows, macOS, Linux) and ensure you install the complete version of FFmpeg.

(2) Download a packages containing binaries [ffmpeg-git-full.7z](https://www.gyan.dev/ffmpeg/builds/ffmpeg-git-full.7z) from certified developers webpage https://www.gyan.dev/ffmpeg/builds/. 
Extract and rename the extracted folder as "ffmpeg".

(3) Move the folder it in a proper folder like C:\Program Files\

Add FFmpeg tools to Environment Variables

If you haven’t already, you need to add the FFmpeg path to the system environment variables. 

Here’s how to do this on Windows:
(3) Locate the directory where you extracted or installed FFmpeg. It should contain ffmpeg.exe, ffprobe.exe anf ffplay.exe.
(4, 5 , 6) Go to “Control Panel” → “System” → “Advanced System Settings” → “Environment Variables.”
In the “System variables” section, select “Path” and click “Edit.”
Add a new entry with the full path to the folder that contains ffmpeg.exe and ffprobe.exe.
Click “OK” to close all windows.



Verify FFmpeg Installation:
Open the Command Prompt (CMD) and type:
ffmpeg -version
If installed correctly, you should see the version of ffmpeg. 
Otherwise, the command won’t be recognized.


After confirming that ffmpeg and ffprobe is installed correctly, you are ready to use the tools!


--------------------------------------------------
Reference:
https://ffmpeg.org/ffmpeg-filters.html#v360

The v360 filter accepts the following formats:
‘e’
‘equirect’
Equirectangular projection.

‘c3x2’
‘c6x1’
‘c1x6’
Cubemap with 3x2/6x1/1x6 layout.

Note
Order of faces for the input/output cubemap. 
Designation of directions:
‘r’ right
‘l’ left
‘u’ up
‘d’ down
‘f’ forward
‘b’ back
Default value is ‘rludfb’

Cumemap Faces 6x1 Order
| Right | Left | Up | Down | Front | Back |

Cumemap Faces 3x2 Order
| Right | Left  | Up   |
| Down  | Front | Back |


TYPE OF CONVERSION ANT TOOL (file.bat)


| Conversion Video <-> Frames         | Images                   | Filemname            | GitHub Link                                |
|-------------------------------------|--------------------------|----------------------|--------------------------------------------|
| video to frames                     |                          | video_2_frames       | [Link GitHub](https://github.com/esempio1) |
| frames to video                     |                          | frames_2_video       | [Link GitHub](https://github.com/esempio1) |

| Conversion - Video to Video         | Images                   | Filemname            | GitHub Link                                |
|-------------------------------------|--------------------------|----------------------|--------------------------------------------|
| equirect to cube 6x1                |                          | equirect_2_cube6x1   | [Link GitHub](https://github.com/esempio1) |
| equirect to cube 3x2                |                          | equirect_2_cube3x2   | [Link GitHub](https://github.com/esempio2) |
| equirect to cubemap faces           |                          | equirect_2_cubefaces | [Link GitHub](https://github.com/esempio2) |
| cubemap 6x1 to equirect             |                          | cube6x1_2_equirect   | [Link GitHub](https://github.com/esempio3) |
| cubemap 3x2 to equirect             |                          | cube3x2_2_equirect   | [Link GitHub](https://github.com/esempio4) |
| cubemap 6x1 to cubemap faces        |                          | cube6x1_2_cubefaces  | [Link GitHub](https://github.com/esempio2) |

| Conversion - Video to Frames        | Images                   | Filemname                  | GitHub Link                                |
|-------------------------------------|--------------------------|----------------------------|--------------------------------------------|
| equirect to cubemap 6x1 frames      |                          | equirect_2_cube6x1frames   | [Link GitHub](https://github.com/esempio1) |
| equirect to cubemap 3x2 frames      |                          | equirect_2_cube3x2frames   | [Link GitHub](https://github.com/esempio2) |
| equirect to cubemap faces frames    |                          | equirect_2_cubefacesframes | [Link GitHub](https://github.com/esempio2) |
| cubemap 6x1 to equirect frames      |                          | cube6x1_2_equirectframes   | [Link GitHub](https://github.com/esempio3) |
| cubemap 3x2 to equirect frames      |                          | cube3x2_2_equirectframes   | [Link GitHub](https://github.com/esempio4) |
| cubemap 6x1 to cubemap faces frames |                          | cube6x1_2_cubefacesframes  | [Link GitHub](https://github.com/esempio2) |

| Conversion - Frames to Video        | Images                   | Filemname                  | GitHub Link                                |
|-------------------------------------|--------------------------|----------------------------|--------------------------------------------|
| equirect frames to cubemap 6x1      |                          | equirectframes_2_cube6x1   | [Link GitHub](https://github.com/esempio1) |
| equirect frames to cubemap 3x2      |                          | equirectframes_2_cube3x2   | [Link GitHub](https://github.com/esempio2) |
| equirect frames to cubemap faces    |                          | equirectframes_2_cubefaces | [Link GitHub](https://github.com/esempio2) |
| cubemap 6x1 frames to equirect      |                          | cube6x1frames_2_equirect   | [Link GitHub](https://github.com/esempio3) |
| cubemap 3x2 frames to equirect      |                          | cube3x2frames_2_equirect   | [Link GitHub](https://github.com/esempio4) |
| cubemap 6x1 frames to cubemap faces |                          | cube6x1frames_2_cubefaces  | [Link GitHub](https://github.com/esempio2) |





NOTE

ffmpeg command

Convert video format from equirectangular to cubemap 3x2
-ffmpeg -i equirect.mp4 -vf "v360=equirect:cube3x2" cube3x2.mp4

Convert video format from cubemap6x1 to equirectangular
-ffmpeg -i cube6x1.mp4 -vf "v360=c6x1:equirect" equirect.mp4

Create video from a sequences of cubamap 6x1 (rludfb) images
(names: frame000001.png, frame000002.png, frame000003.png, ...)
-ffmpeg -r 30 -i frame0%05d.png videocube6x1.mp4

Convert sequence of cubemap 6x1 images to equirectangular and create video with custom compression
ffmpeg -r 30 -i frame0%05d.png -vf "v360=c6x1:equirect" -c:v libx264 -crf 16 -preset slow -r 30 equirectangular.mp4

![sequence-conversion-video](https://github.com/user-attachments/assets/c6ce06a9-968b-4b71-9fc8-c1514961af98)


To convert a sequence of frames and save it to a different panoramic format open and try the files.bat!
Just copy them in the folder and you can convert also in sigular face of the cube.
