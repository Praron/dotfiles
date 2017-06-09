#!/bin/zsh

old_state="${"$(xinput --list-props 12 | grep 'Scrolling Button (')": -1}"
echo $old_state
if [ "$old_state" = "2" ] ; then
	xinput set-prop 12 "libinput Button Scrolling Button" 0
	notify-send -u low "Trackpoint" "Disable scroll emulation"
else
	xinput set-prop 12 "libinput Button Scrolling Button" 2
	notify-send -u low "Trackpoint" "Enable scroll emulation"
fi