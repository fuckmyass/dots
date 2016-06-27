#!/bin/sh

i3-nagbar -t warning -f latinmodernmonolight -m 'You pressed the power button. Do you really want to exit i3? This will end your X session.' -b 'Shut Down' 'systemctl poweroff' -b 'Reboot' 'systemctl reboot' -b 'Hibernate' 'systemctl hibernate' -b 'Suspend' 'systemctl suspend' -b 'Exit i3' 'pkill i3'


