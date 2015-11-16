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
xset +fp /usr/share/fonts/artwiz-fonts
xset +fp /home/shit-twins/fonts/Input Fonts
xset +p /usr/share/fonts/adobe-source-code-pro
xset +p /usr/share/fonts/adobe-source-sans-pro
xset +p /usr/share/fonts/anonymous-pro
xset +p /usr/share/fonts/creep
xset +p /usr/share/fonts/envypn
xset +p /usr/share/fonts/fantasque-sans-mono
xset +p /usr/share/fonts/Hack
xset +p /usr/share/fonts/inconsolata-dz for Powerline
xset +p /usr/share/fonts/ippytrax
xset +p /usr/share/fonts/kakwafont
xset +p /usr/share/fonts/lemon
xset +p /usr/share/lokaltog-fonts
xset +p /usr/share/fonts/Menlo-for-Powerline
xset +p /usr/share/fonts/modd
xset +p /usr/share/fonts/peep
xset +p /usr/share/fonts/Prelude
xset +p /usr/share/fonts/PragmataPro
xset +p /usr/share/fonts/Sauce Code
xset +p /usr/share/fonts/uushi
xset +p /usr/share/fonts/gmnterm
xset +p /usr/share/fonts/siji
xset +p /usr/share/fonts/San Francisco
xset fp rehash

# set the cursor
xsetroot -cursor_name left_ptr &

# start term in background
urxvtd -q -f -o &

# set wallpaper
wallshuf &

# start compositor
compton -b &
# compton -f -D8 -I0.05 -O0.05 &
# compton -bCG -f -D8 -I0.05 -O0.05 &

# start mpd & scrobbler
mpd &
mpdscribble &

# load X resources
xrdb -load ~/.Xdefaults

# monitor settings
exec xsettingsd &
exec xscreensaver &
exec xset r rate 200 40 &
exec redshift &

# run some scripts
while :; do battery_check; sleep 120; done &
exec conky -c ~/conkys/albumart &
exec tint2 &

# Start window manager in the foreground. If this dies, X dies.
exec i3
