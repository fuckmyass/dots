#!/bin/sh
if [[ -n "$(mpc -f %title% current)" ]]; then
	np=$(mpc -f %title% current)
else
	np="Not playing"
fi
echo "$np"
