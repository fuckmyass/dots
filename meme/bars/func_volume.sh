#!/bin/sh
bar_bg="#F2F1B9"
bar_fg="#a3aa5e"
AMASTER=`amixer get Master | awk 'END{gsub(/\[|\]|%/,""); print $4}'`
ASTAT=`amixer get Master | awk 'END{gsub(/\[|\]|%/,""); print $6}'`

if [[ $ASTAT = "on" ]]; then
    PERCBAR=`echo "$AMASTER"\
        | gdbar -bg $bar_bg -fg $bar_fg -h 10 -w 60 -s o -ss 1 -sw 2 -nonl`
else
    PERCBAR=`echo 0 \
        | gdbar -bg $bar_bg -fg $bar_fg -h 10 -w 60 -s o -ss 1 -sw 2 -nonl`
fi

echo "^ca(4,amixer set Master 1%+)^ca(5,amixer set Master 1%-)$PERCBAR^ca()^ca()"

#darkred="#FF5879"
#black="#F2F1B9"
#green="#7CBF9E"
#sound=$(amixer get Master | sed -n 's/.*\[\([a-z]\+\)\]$/\1/p')
#vol=$(echo "`amixer get Master | sed -n 's/^.*\[\([0-9]\+\)%.*$/\1/p'`/10" | bc)
#on=$(eval printf %${vol}s | sed 's/\s/☷/g')
#off=$(eval printf %$(echo "10 - $vol" | bc)s | sed 's/\s/☷/g')
#    echo -ne "^fg($green)◂⋑ ^fg($darkred)$on^fg($black)$off"
