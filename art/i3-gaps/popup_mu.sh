#!/bin/bash

#music pop-up

LINES='0'
WIDTH='245'
HEIGHT='20'
YPOS='40'
XPOS='1080'
ACT='onstart=uncollapse;button1=exit;button3=exit'
PAD='  '
TIME='3'
FONT="wenquanyi zen hei mono-9"

CMD_MUTOGGLE="^ca(1,mpc toggle -q)"
CMD_MUNEXT="^ca(1, mpc next -q)"
CMD_MUPREV="^ca(1, mpc prev -q)"
CMD_END="^ca()"

ICON_PATH="/home/shit-twins/dzen/icons"
ICON_NOTE="^i(${ICON_PATH}/note1.xbm)"
ICON_ARTIST="^i(${ICON_PATH}/messenger2.xbm)"
ICON_ALBUM="^i(${ICON_PATH}/cd.xbm)"
ICON_PLAY="^i(${ICON_PATH}/play1.xbm)"
ICON_NEXT="^i(${ICON_PATH}/skip1.xbm)"
ICON_PREV="^i(${ICON_PATH}/prev1.xbm)"

BG='#534960'
FGCOL_YEL="^fg(#f2f2f2)"
FGCOL_RED="^fg(#f2f2f2)"
FGCOL_BLU="^fg(#f2f2f2)"
FGCOL_MAG="^fg(#f2f2f2)"

echo -e "\n ${FGCOL_YEL}${ICON_NOTE} $(mpc current -f %title%)\n ${FGCOL_BLU}${ICON_ARTIST} $(mpc current -f %artist%)\n ${FGCOL_MAG}${ICON_ALBUM} $(mpc current -f %album%)\n${FGCOL_RED}                        ${CMD_MUPREV}${ICON_PREV}${CMD_END} ${CMD_MUTOGGLE}${ICON_PLAY}${CMD_END}  ${CMD_MUNEXT}${ICON_NEXT}${CMD_END} ${FGCOL_DEF}" | dzen2 -p "$TIME" -fn "$FONT" -l 4  -bg "$BG" -h "$HEIGHT" -y "$YPOS" -x "$XPOS" -w "$WIDTH" -ta l -e 'onstart=uncollapse;button3=exit'
