#!/bin/bash

ICON_COLOR="#434850"
BATTERY_CHARGING_ICON="/home/shit-twins/dzen/icons/bat_full_01.xbm"
BATTERY_DISCHARGING_ICON="/home/shit-twins/dzen/icons/bat_low_01.xbm"
BATTERY_MISSING_ICON="/home/shit-twins/dzen/icons/ac_01.xbm"
BATTERY_CRITICAL_PERCENTAGE=10
BATTERY_CRITICAL_FG_COLOR="#CB6077"
BATTERY_CRITICAL_BG_COLOR="#434850"
BAR_STYLE="-w 33 -h 10 -s o -ss 1 -sw 4 -nonl"
BAR_FG_COLOR="#434850"
BAR_BG_COLOR="#434850"

icon() {
	echo "^fg($ICON_COLOR)^i($1)^fg()"
}

bar() {
	echo $1 | gdbar $BAR_STYLE -fg $BAR_FG_COLOR -bg $BAR_BG_COLOR
}

battery_icon() {
	if [ "$battery_status" == "Charging" ]; then
		icon "$BATTERY_CHARGING_ICON"
	elif [ "$battery_status" == "Discharging" ]; then
		icon "$BATTERY_DISCHARGING_ICON"
	else
		icon "$BATTERY_MISSING_ICON"
	fi
}

battery_percentage() {
	percentage=$(acpi -b | cut -d "," -f 2 | tr -d " %")
	if [ -z "$percentage" ]; then
		echo "AC"
	elif [ $percentage -le $BATTERY_CRITICAL_PERCENTAGE ] && [ $battery_status == "Discharging" ]; then
		echo 100 | gdbar $BAR_STYLE -fg $BATTERY_CRITICAL_FG_COLOR -bg $BATTERY_CRITICAL_BG_COLOR
	else
		bar "$percentage"
	fi
}


battery() {
	battery_status=$(acpi -b | cut -d ' ' -f 3 | tr -d ',')
	echo $(battery_icon) $(battery_percentage)
}

	echo "$(battery)"
