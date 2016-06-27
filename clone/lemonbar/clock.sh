#!/bin/sh
# Dylan's Lemonbar Clock

# Source colors
source ~/bin/colors.sh

while :; do
    echo "       %{c}$(date +'%Y')年$(date +'%m')月$(date +'%d')日 $(date +'%H':'%M')"
	sleep 2s
done |

lemonbar -g "160x25+1180+730" -d -p -f "$font" -f "$font1" -B "#$white" -F "#$black"

