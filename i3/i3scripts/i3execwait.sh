#!/bin/bash
# ---------------------------------------------------------------------------
# execute program and wait till xwindow with title will be visible, then move
# it to specified i3 workspace and move workspace to specified monitor

# Copyright 2021-2021, tomas horak <tomashorak@post.cz>

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License at <http://www.gnu.org/licenses/> for
# more details.

# Usage: i3execwait program caption workspace monitor
# ./i3execwait.sh teams '| Microsoft Teams' 2 eDP-1

# Revision history:
# ---------------------------------------------------------------------------
prog="$1"
wincaption="$2"
workspace="$3"
winmonitor="$4"

$prog &

start_time=$SECONDS
elapsed=0
xwinid=""
while [[ -z "$xwinid" ]] && [[ $elapsed -le 10 ]]; do
	wininfo=$(xwininfo -root -children -tree | grep -i "$wincaption")
	if [[ ! -z "$wininfo" ]]; then
		# winid is first on the line separated by space
		xwinid=$(echo $wininfo | sed -n -r -e 's/^([^ ]+) .*$/\1/p')
		isviewable=$(xwininfo -id $xwinid | sed -n -e '/Map State: IsViewable/p')
		if [[ -z "$isviewable" ]]; then
			# until window is visible loop continues
			xwinid=""
		fi
	fi
	sleep 0.1
	elapsed=$(( SECONDS - start_time ))
done

if [[ ! -z "$xwinid" ]]; then
	i3cmd="[id=\"$xwinid\"] move container to workspace $workspace"
	echo $i3cmd
	i3-msg $i3cmd
	i3cmd="[workspace=$workspace] move workspace to output $winmonitor"
	echo $i3cmd
	i3-msg $i3cmd
else
	echo "window with caption containing $wincaption not found"
fi


