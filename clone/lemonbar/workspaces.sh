#!/bin/sh
# Dylan's Lemonbar Clock

# Source colors
source ~/bin/colors.sh

while :; do
    echo "       %{c}$(i3-msg -t get_outputs | sed 's/.*"current_workspace":"\([^"]*\)".*/\1/')"
	sleep 2s
done |

lemonbar -g "100x25+25+730" -d -p -f "$font" -f "$font1" -B "#$white" -F "#$black"

