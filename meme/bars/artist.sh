#!/bin/sh
#if [[ -n "$(mpc -f %title% current)" ]]; then
#	np=$(mpc -f %title% current)
#else
#	np="Not playing"
#fi
#echo "$np"

	songa=$(mpc current -f "%artist%")
	songb=$(mpc current -f "%title%")
if [[ -z $songb ]]; then
	songb=$(mpc current -f "%file%"|cut -d "/" -f2|sed 's/.mp3$//')
fi
if [[ -z $(mpc current)  ]]; then
	songa=""; songb=""
fi
if [[ $(mpc | sed -n 's/^.*m:\so\(\w\).*$/\1/p') = "f" ]]; then
	muscolor=$black
else
	muscolor=$darkred
fi
echo "$songb"