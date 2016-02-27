#!/bin/sh
#
# ~/.xinitrc
#
# Executed by startx (run your window manager from here)

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

# fonts
xset +fp /usr/share/fonts/TTF
xset +fp /usr/share/fonts/local
xset fp rehash

# set the cursor
xsetroot -cursor_name left_ptr &

# start term in background
urxvtd -q -f -o &

# set wallpaper
sh ~/.fehbg &
# wallshuf &

# start compositor
# compton -b &
compton -o 0.6 -r 20 -l -30 -t -10 -cCGb &

# start mpd & scrobbler
mpd &
mpdscribble &

# load X resources
xrdb -load ~/.Xdefaults

# monitor settings
xsettingsd &
xscreensaver &
xset r rate 200 40 &

# run some scripts
tint2 &
while :; do battery_check; sleep 120; done &
bars.sh &
redshift &
urxvt -e tmux &

# Start window manager in the foreground. If this dies, X dies.
exec i3
