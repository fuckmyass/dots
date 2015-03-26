#!/bin/bash

# pop-up calendar for dzen
#
# based on (c) 2007, by Robert Manea
# http://dzen.geekmode.org/dwiki/doku.php?id=dzen:calendar
# modified by urukrama
# modified by senft
# modified by easysid

WIDTH=150
LINES=8

source $(dirname $0)/dzen_popup_config
source $(dirname $0)/mouselocation.sh

# define pipe
PIPE=/tmp/calendar_pipe

# if terminated by TERM
trap "rm -f $PIPE" SIGTERM

TODAY=$(expr `date +'%d'` + 0)
MONTH="10#$(date +'%m')"
YEAR="10#$(date +'%Y')"

MM=${1:-"$MONTH"}
YY=${2:-"$YEAR"}
NEXT=$((MM+1))
PREV=$((MM-1))
let Y_NEXT=Y_PREV=YY
if [[ $NEXT -eq 13 ]]; then
    NEXT=1
    Y_NEXT=$((YY+1))
fi

if [[ $PREV -eq 0 ]]; then
    PREV=12
    Y_PREV=$((YY-1))
fi

# generate calender
if [[ $MM -eq $MONTH ]] && [[ $YY -eq $YEAR ]]; then  # current month, highlight header and date
    CAL=$(cal | sed -re "s/^(.*[A-Za-z][A-Za-z]*.*)$/^fg($highlight)\1^fg()/;s/(^|[ ])($TODAY)($|[ ])/\1^bg($highlight2)^fg($highlight)\2^fg()^bg()\3/")
else  # another month, just highlight header
    CAL=$(cal "$MM" "$YY" | sed -re "s/^(.*[A-Za-z][A-Za-z]*.*)$/^fg($highlight)\1^fg()/")
fi

# read from pipe
if [[ ! -e $PIPE ]]; then
  mkfifo "$PIPE"
  ( dzen2 -u -x $XPOS -w $WIDTH -l $LINES -sa 'c' -title-name 'popup_calendar' -fn "$FONT" ${OPTIONS} < "$PIPE"
   rm -f "$PIPE") &
fi

# feed the pipe
(
echo "$CAL"
echo "^fg($highlight)^ca(1, $0 $PREV $Y_PREV)<< Prev^ca()        ^ca(1, $0 $NEXT $Y_NEXT)Next >>^ca()^fg()"
sleep 8s
) > "$PIPE"

