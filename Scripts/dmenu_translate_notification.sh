#!/bin/bash

word="$(echo '' | dmenu -p 'Translate:')"
if [ "$word" != "" ]; then
notify-send "<b>$word</b>" "$(trans -b :ru "$word" | sed 's/ null//g')"
fi
