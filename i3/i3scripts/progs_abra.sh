#! /bin/sh
#i3-msg '[workspace=1] exec thunderbird, move workspace to output eDP-1;'
# sometimes window just not moved or to bad workspace when active workspace is same,
# so set active workspace to unused one
i3-msg workspace number 9
~/.config/i3scripts/i3execwait.sh thunderbird 'Mozilla Thunderbird' 1 eDP-1
i3-msg '[workspace=1] exec skypeforlinux, move workspace to output eDP-1;'
i3-msg '[workspace=3] exec /opt/viberimg/viber.AppImage, move workspace to output eDP-1;'
~/.config/i3scripts/i3execwait.sh teams '| Microsoft Teams' 2 eDP-1
#virsh start win10
#sleep 5
i3-msg '[workspace=10] exec virt-viewer --full-screen --domain-name win10 --wait, move workspace to output HDMI-1 eDP-1;'
virsh start win10

