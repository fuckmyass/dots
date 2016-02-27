#!/bin/bash

WIFI_GOOD="#A2D9B1"
WIFI_FAIR="#E5C078"
WIFI_POOR="#FF5879"
WIFI_DEV="wlo1"
ICONS="/home/shit-twins/dzen/icons"

# Return color based on WiFi signal strength
# usage: wifi_strength $DEVICE $WIFI_GOOD $WIFI_FAIR $WIFI_POOR
wifi_strength () {
  dev="$1"
  signal=$(iw dev $dev link | grep signal | egrep -o '[0-9]+')
        
  if [ $signal -lt 68 ]; then
      icon="^fg($2)^i($ICONS/wireless5.xbm)"
#      color=$2
#    icon=^i("$ICONS/mail2.xbm")
  elif [ $signal -lt 70 ]; then
      icon="^fg($3)^i($ICONS/wireless6.xbm)"
#    color=$3 
#    icon=^i("$ICONS/mail2.xbm")
  else
      icon="^fg($4)^i($ICONS/wireless7.xbm)"
#    color=$4 
#    icon=^i("$ICONS/mail2.xbm")
  fi
  #printf "%s\n" "^fg($color)($icon)"
  printf "%s\n" "$icon"
} 

echo "$(wifi_strength $WIFI_DEV $WIFI_GOOD $WIFI_FAIR $WIFI_POOR) $(essid -w $WIFI_DEV)"
