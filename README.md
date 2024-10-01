# FFmpegSphericalVideoConversion
Transform video projections such as cubemap, equirectangular, and more

This repository provides a set of scripts that simplify the process of converting and editing 360° and spherical video formats using FFmpeg. Actually it doesn't cover all the combination. The scripts are vary basic, it will be easy to custumize input and output format starting from the examples.

Whether you're working with cubemap formats (e.g., 6x1 or 3x2) or need to convert to equirectangular projections, these tools are designed for easy integration into your workflow. Ideal for anyone working with VR, panoramic, or immersive media.

Features:
1-Convert standard panoramic images sequence and video 
2-Batch processing for image sequences
3-Split and combine panoramic formats
4-No quality loss during video processing
5-Customizable frame rates and video output settings
6-Simple integration into workflows using FFmpeg

Reference:
https://ffmpeg.org/ffmpeg-filters.html#v360


Feel free to customize any part of the text further to suit your preferences!


Order of faces for the input/output cubemap. 
Designation of directions:
‘r’ right
‘l’ left
‘u’ up
‘d’ down
‘f’ forward
‘b’ back
Default value is ‘rludfb’


EXEMPLE OF USING

If you have a video 


If you have a folder with a sequence of cubemap 6x1 (rludfb) images:
frame000001.png, frame000002.png, frame000003.png, ...

To convert cubemap video cube 6x1 to equirectangular videos using a default mp4 compression you have two options:

A
Open cmd.exe, go to the folder containing the frames
-type cd C:\Users\username\images\sequence-001
and execute this command:
ffmpeg -i cube6x1.mp4 -vf "v360=c6x1:equirect" equirect.mp4
(the script is cointained in the repository: cube6x1_2_equirect.txt)

b
copy this file bat: 6x1_equirect.bat
in the folder cintaining the sequences and he wil do the same, with less operation! and more, it will describe the compression of video 
ffmpeg -r 30 -i frame0%05d.png -vcodec libx264 -crf 16 -pix_fmt yuv420p video.mp4