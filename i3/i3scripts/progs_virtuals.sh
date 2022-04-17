#! /bin/sh
i3-msg '[workspace=1] exec skypeforlinux, move workspace to output eDP-1;'
virsh start win10
sleep 5
i3-msg '[workspace=10] exec virt-viewer --full-screen --domain-name win10 --reconnect, move workspace to output HDMI-1 eDP-1;'
