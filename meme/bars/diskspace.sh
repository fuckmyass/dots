#!/bin/sh
#SDA2=$(df -h / | awk '/\/$/ {print $5}' | tr -d '%')
CRIT_COLOR="#FF5879"
bar_bg="#F2F1B9"
bar_fg="#a3aa5e"
SDA3=$(df -h /home | awk '/home/ {print $5}' | tr -d '%')
if [[ ${SDA3} -gt 60 ]] ; then
	echo -n "^ /:${SDA3}% $(echo $SDA3 | gdbar -fg $CRIT_COLOR -bg $bar_bg -h 10 -w 60 -s o -ss 1 -sw 2 -nonl)"
else
	echo -n "^ /:${SDA3}% $(echo $SDA3 | gdbar -bg $bar_bg -fg $bar_fg -h 10 -w 60 -s o -ss 1 -sw 2 -nonl)"
fi
