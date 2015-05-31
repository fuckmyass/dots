#!/bin/bash

WIFI_GOOD="#b5bd68"
WIFI_FAIR="#f0c674"
WIFI_POOR="#cc6666"
WIFI_DEV="wlo1"

# Return color based on WiFi signal strength
# usage: wifi_strength $DEVICE $WIFI_GOOD $WIFI_FAIR $WIFI_POOR
wifi_strength () {
  dev="$1"
  signal=$(iw dev $dev link | grep signal | egrep -o '[0-9]+')
        
  if [ $signal -lt 68 ]; then
    color=$2
  elif [ $signal -lt 70 ]; then
    color=$3
  else
    color=$4
  fi
  printf "%s\n" "^fg($color)"
} 

echo "$(wifi_strength $WIFI_DEV $WIFI_GOOD $WIFI_FAIR $WIFI_POOR) $(essid -w $WIFI_DEV)"
