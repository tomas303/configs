#! /bin/sh
#i3-msg 'workspace 1;exec thunderbird; move workspace to output eDP-1;'
#i3-msg 'workspace 1;exec skypeforlinux; move workspace to output eDP-1;'
#i3-msg 'workspace 2;exec doublecmd; move workspace to output eDP-1;'

~/.config/i3scripts/i3execwait.sh thunderbird 'Mozilla Thunderbird' 1 eDP-1
