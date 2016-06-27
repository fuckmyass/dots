#!/bin/bash
# Dylan's cover art script

# Set terminal title
echo -e '\033]2;'cover.sh'\007'

# Hide terminal cursor
tput civis

# Cover directory
dir=$HOME/.config/ario/covers/

# Image size
width=150
height=155

# Image offset
xoffset=0
yoffset=0

# Image format
format=jpg

while :; do
	currentalbum=$(mpc -f %artist%-%album% current 2>/dev/null)
    img="$dir$currentalbum.$format"

	w3m_command="0;1;$xoffset;$yoffset;$width;$height;;;;;$img\n4;\n3;"
	echo -e "$w3m_command" | /usr/lib/w3m/w3mimgdisplay

    # Update on mpd play/pause/next/prev and database update
	sleep .5s > /dev/null 2>&1
done

