#!/bin/sh
#SONG=$(mpc current)

# Source colors
source ~/bin/colors.sh
MSGW=$(txtw -f chicago $SONG)
BW=300
BH=25
BX=1610
BY=10
BARF=metis
BAR_BG="#$white"
BAR_FG="#$black"
bar_opts="-g 290x25+880+730 -f "$font" -B "#$white" -F "#$black" -d"
(
tx_len="32"
echo $(mpc current) | skroll -r -l -n $tx_len &
sleep 30 && kill $!
) | lemonbar ${bar_opts}


