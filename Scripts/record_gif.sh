#!/bin/bash
TMP_AVI=$(mktemp /tmp/outXXXXXXXXXX.avi)
ffcast -s % ffmpeg -y -f x11grab -show_region 1 -framerate 15 \
    -video_size %s -i %D+%c -codec:v huffyuv                  \
    -vf crop="iw-mod(iw\\,2):ih-mod(ih\\,2)" $TMP_AVI         \
; convert -limit memory 32 -set delay 5 -layers Optimize $TMP_AVI ~/Screenshots/gifs/$(date "+%b_%d_%Y_%H.%M.%S").gif
