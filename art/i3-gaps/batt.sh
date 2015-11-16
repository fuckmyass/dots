#!/bin/sh


BATC="/sys/class/power_supply/BAT0/capacity"
BATS="/sys/class/power_supply/BAT0/status"

STAT=`sed -n p ${BATS}`
LVL=`sed -n p ${BATC}`

if [ ${STAT} = "Charging" ] ; then
    echo "Charging, ${LVL}%"
elif [ ${STAT} = "Full" ] ; then
    echo "Charged"
else
    echo "Unplugged, ${LVL}%"
fi
