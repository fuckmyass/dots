#!/bin/bash

#triggers bars'n'shits

ICON_PATH="/home/shit-twins/dzen/icons"
ICON_CLOCK="^i(${ICON_PATH}/clock2.xbm)"
ICON_PACMAN="^i(${ICON_PATH}/pacman1.xbm)"
ICON_MUSIC="^i(${ICON_PATH}/note1.xbm)"
ICON_UP="^i(${ICON_PATH}/uparrow1.xbm)"
ICON_DOWN="^i(${ICON_PATH}/downarrow1.xbm)"
ICON_VOL="^i(${ICON_PATH}/vol1.xbm)"
ICON_PLAY="^i(${ICON_PATH}/play1.xbm)"
ICON_NEXT="^i(${ICON_PATH}/skip1.xbm)"
ICON_PREV="^i(${ICON_PATH}/prev1.xbm)"
ICON_WIFI="^i(${ICON_PATH}/wifi_01.xbm)"
FONT="Pragmata Pro-8"
HEIGHT="30"
YPOS="735"

FGCOL_DEF="^fg(#dedfcd)"
FGCOL_RED="^fg(#A54242)"
FGCOL_GRE="^fg(#8C9440)"
BGCOL="#1D1F21"

CMD_POPUP_MU="^ca(1, ~/bin/popup_mu.sh)"
CMD_END="^ca()"

#Music 
while true; do echo "${FGCOL_RED}${ICON_MUSIC}${FGCOL_DEF} $(exec sh artist.sh) $(exec sh func_mpc.sh)"; sleep 1; done | dzen2 -e 'button1=exec:~/bin/popup_mu.sh' -fn "$FONT" -bg "$BGCOL" -y "$YPOS" -x 20 -h "$HEIGHT" -w '400' -ta c &

#Wifi 
while true; do echo "${FGCOL_RED}${ICON_WIFI}${FGCOL_DEF} $(exec sh wifi.sh)"; sleep 1; done | dzen2 -e - -fn "$FONT" -bg "$BGCOL" -y "$YPOS" -x 520 -h "$HEIGHT" -w '100' -ta c &

#Batt
while true; do echo "${FGCOL_DEF} $(exec sh panel_battery)  $(exec sh batt.sh)"; sleep 1; done | dzen2 -e - -fn "$FONT" -bg "$BGCOL" -y "$YPOS" -x 720 -h "$HEIGHT" -w '150' -ta c &

#Vol
while true; do echo "${FGCOL_RED}${ICON_VOL} ${FGCOL_DEF}$(exec sh func_volume.sh)"; sleep 2; done | dzen2 -e 'button1=exec:urxvt -e alsamixer -g;button3=exec:amixer -q set Master 2-' -fn "$FONT" -bg "$BGCOL" -y "$YPOS" -x 966 -h "$HEIGHT" -w '120' -ta c &

#Time
while true; do echo "${FGCOL_RED}${ICON_CLOCK} ${FGCOL_DEF}$(date +'%a %d %b')   |  $(date +%R)"; sleep 1; done | dzen2 -e - -fn "$FONT" -bg "$BGCOL" -y "$YPOS" -x 1166 -h "$HEIGHT" -w '180' -ta c
