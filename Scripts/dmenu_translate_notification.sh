#!/bin/bash

word="$(echo '' | dmenu -p 'Translate:')"
if [ "$word" != "" ]; then
notify-send "$word" "$(trans -b :ru "$word" | sed 's/ null//g')"
fi
