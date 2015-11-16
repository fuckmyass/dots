#!/bin/bash

BAR_STYLE="-w 33 -h 10 -s o -ss 1 -sw 4 -nonl"
BAR_FG_COLOR="#434850"
BAR_BG_COLOR="#434850"
BAR_STYLE="-w 33 -h 10 -s o -ss 1 -sw 4 -nonl"
BAR_FG_COLOR="#434850"
BAR_BG_COLOR="#434850"

bar() {
	echo $1 | gdbar $BAR_STYLE -fg $BAR_FG_COLOR -bg $BAR_BG_COLOR
}
wireless_quality() {
	quality_bar=$(bar "$(iw dev wlo1 link | grep signal | egrep -o '[0-9]+')")
	echo "^ca(3, $WIRELESS_CLIENT)$quality_bar^ca()"
}

	echo "$(wireless_quality)"