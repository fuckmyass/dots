#! /bin/sh

position(){
pos=$(mpc | awk 'NR==2' | awk '{print $4}' | sed 's/(//' | sed 's/%)//')
bar=$(echo $pos | gdbar -w 60 -h 3 -fg "#FF6666" -bg "#AAC9B0")
echo -n "$bar"
return
}

echo " $(position)" 
