#!/bin/bash

#triggers bars'n'shits

ICON_PATH="/home/shit-twins/dzen/icons"
ICON_CLOCK="^i(${ICON_PATH}/clock3.xbm)"
ICON_PACMAN="^i(${ICON_PATH}/pacman1.xbm)"
ICON_MUSIC="^i(${ICON_PATH}/music_icon.xbm)"
ICON_UP="^i(${ICON_PATH}/uparrow1.xbm)"
ICON_DOWN="^i(${ICON_PATH}/downarrow1.xbm)"
ICON_VOL="^i(${ICON_PATH}/vol1.xbm)"
ICON_PLAY="^i(${ICON_PATH}/play1.xbm)"
ICON_NEXT="^i(${ICON_PATH}/skip1.xbm)"
ICON_PREV="^i(${ICON_PATH}/prev1.xbm)"
ICON_WIFI="^i(${ICON_PATH}/wifi_01.xbm)"
ICON_DISK="^i(${ICON_PATH}/home1.xbm)"
FONT="MS Gothic-9"
FONT1="MS Gothic-10"
HEIGHT="25"
XPOS="1140"

WHITE="#F2F1B9"
RED="#F99595"
GREEN="#a3aa5e"
BLUE="#556364"
BLACK="#41474A"
PINK="#b58487"

CMD_END="^ca()"

#Time
#while true; do echo "${RED}  ${ICON_CLOCK} ${WHITE}$(date +'%a %d %b')  |  $(date +%R)"; sleep 1; done | dzen2 -e - -fn "$FONT" -bg "$BLACK" -y 25 -x 1170 -h "$HEIGHT" -w '170' -ta c

#Time
while true; do echo "^bg($BLACK) ^fg($WHITE)$(date +'%Y')年$(date +'%m')月$(date +'%d')日 ^fg($RED)| ^fg($WHITE)$(date +'%I':'%M') ^bg($RED)^fg($BLACK) $(date +'%P') " ; sleep 1; done | dzen2 -e - -fn "$FONT1" -y 25 -x 1147 -h 30 -w '193' -ta c &

#Vol
while true; do echo " $(exec sh func_volume.sh) ^bg($RED)^fg($BLACK) 体積 " ; sleep 2; done | dzen2 -e 'button1=exec:urxvt -e alsamixer -g;button3=exec:amixer -q set Master 2-' -fn "$FONT" -bg "$BLACK" -y 65 -x 1231 -h "$HEIGHT" -w '109' -ta c &

#Disc
while true; do echo "^bg($BLACK)^fg($WHITE) $(exec sh diskspace.sh) ^bg($RED)^fg($BLACK) 家 " ; sleep 1; done | dzen2 -e - -fn "$FONT" -bg "$BLACK" -y 100 -x 1219 -h "$HEIGHT" -w '121' -ta c &

#Wifi 
while true; do echo "^bg($BLACK)^fg($WHITE)  $(exec sh wifi.sh) ^bg($RED)^fg($BLACK) 網 " ; sleep 1; done | dzen2 -e - -fn "$FONT" -bg "$BLACK" -y 135 -x 1236 -h "$HEIGHT" -w '104' -ta c &

#Batt
while true; do echo "^bg($BLACK)^fg($WHITE)  $(exec sh panel_battery) $(exec sh batt.sh) ^bg($RED)^fg($BLACK) 電池 " ; sleep 1; done | dzen2 -e - -fn "$FONT" -bg "$BLACK" -y 170 -x 1193 -h "$HEIGHT" -w '146' -ta c &

#Music 
while true; do echo "^bg($BLACK)^fg($WHITE) $(exec sh artist.sh) ^fg($RED) ${ICON_MUSIC} " ; sleep 1; done | dzen2 -e 'button1=exec:~/bin/popup_mu.sh & disown' -fn "$FONT" -bg "$BLACK" -y 205 -x "$XPOS" -h "$HEIGHT" -w '200' -ta c
