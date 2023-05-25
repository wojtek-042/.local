#!/bin/sh

slstatus &
#mons=$(xrandr | grep -w "connected" | sed 's/\s.*$//')
#extMon=$(echo $mons | awk '{print $2;}')
#intMon=$(echo $mons | awk '{print $1;}')
#xrandr --output $intMon --off --output $extMon --primary
#dunst &
picom &
setxkbmap pl &
#syncthing serve --no-browser &
exec dwm 
