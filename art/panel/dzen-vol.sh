#!/bin/bash

BAR_STYLE="-w 33 -h 10 -s o -ss 1 -sw 4 -nonl"
BAR_FG_COLOR="#434850"
BAR_BG_COLOR="#434850"

bar() {
	echo $1 | gdbar $BAR_STYLE -fg $BAR_FG_COLOR -bg $BAR_BG_COLOR
}

volume() {
	volume=$(amixer get Master | egrep -o "[0-9]+%" | tr -d "%")
        if [ -z "$(amixer get Master | grep "\[on\]")" ]; then
                echo -n "$(echo $volume | gdbar $BAR_STYLE -bg $BAR_BG_COLOR -fg $BAR_BG_COLOR)"
        else
                echo -n "$(bar $volume)"
        fi
}

echo "$(volume)"