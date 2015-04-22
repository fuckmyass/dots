#!/bin/bash
sleep 30 &
conky -c ~/conkys/albumart &
sleep 1 &
conky -c ~/conkys/clock &
sleep 1 &
conky -c ~/conkys/weather &
sleep 1 &
mu_popup.sh &
sleep 1 &
dzvol &
exit 0
