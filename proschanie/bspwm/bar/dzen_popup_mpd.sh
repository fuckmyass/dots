#!/bin/bash

LINES=6
WIDTH=225

source $(dirname $0)/dzen_popup_config

(ARTIST="$(mpc current -f "%artist%")"
TITLE="$(mpc current -f "[%title%|%file%]")"
TIME="$(mpc current -f "(%time%)")"
echo -e "$PAD" ^i"(/home/shit-twins/dzen/icons/music_icon.xbm)" 
echo -e "$PAD" $ARTIST
echo -e "$PAD" ^fg"(#FF6666)"$TITLE
echo -e "$PAD" $TIME
) | dzen2 -p "$TIME" -bg "$BG" -w "$WIDTH" -sa c -y "100" -x "950" -fn "M+ 1m bold-8" -l 4  ${OPTIONS}
