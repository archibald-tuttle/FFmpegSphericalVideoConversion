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


NOTES
Order of faces for the input/output cubemap. 
Designation of directions:
‘r’ right
‘l’ left
‘u’ up
‘d’ down
‘f’ forward
‘b’ back
Default value is ‘rludfb’


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
