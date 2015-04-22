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
xset +fp .fonts/adobe-source-code-pro
xset +fp .fonts/adobe-source-sans-pro
xset +fp /usr/share/fonts/anonymous-pro
xset +fp /usr/share/fonts/artwiz-fonts
xset +fp .fonts/creep
xset +fp .fonts/envypn
xset +fp .fonts/fantasque-sans-mono
xset +fp .fonts/inconsolata-dz for Powerline
xset +fp .fonts/Input Fonts
xset +fp /usr/share/fonts/ippytrax
xset +fp .fonts/kakwafont
xset +fp .fonts/lemon
xset +fp /usr/share/fonts/local
xset +fp .fonts/lokaltog-fixed
xset +fp .fonts/Menlo-for-Powerline
xset +fp /usr/share/fonts/modd
xset +fp .fonts/peep
xset +fp .fonts/Prelude
xset +fp .fonts/PragmataPro
xset +fp .fonts/Sauce Code
xset +fp /usr/share/fonts/TTF
xset +fp /usr/share/fonts/uushi
xset fp rehash

# set the cursor
xsetroot -cursor_name left_ptr &

urxvtd -q -f -o &

# feh background
sh ~/.fehbg &

# compton -b -C &
# compton -f -D8 -I0.05 -O0.05 &
compton -bCG -f -D8 -I0.05 -O0.05 &

mpd &

mpdscribble &

# Load X resources
xrdb -load ~/.Xresources

# exec redshift &

exec start_conkys.sh &

while :; do battery_check; sleep 120; done &

# Start a terminal in the background. If it dies, X still lives.
# exec urxvtc &

# Start window manager in the foreground. If this dies, X dies.
#2bwm
sxhkd &
exec bspwm
