#!/bin/bash
scrot /tmp/screenshot.png
# convert /tmp/screenshot.png -blur 0x5 /tmp/screenshot.png
convert -scale 10% -scale 1000% /tmp/screenshot.png /tmp/screenshot.png
i3lock -i /tmp/screenshot.png -e
rm /tmp/screenshot.png
