#!/bin/bash

# Check connected monitors
PRIMARY="eDP-1"
SECONDARY="DP-3"
FALLBACK_WORKSPACE="I"
SECONDARY_WORKSPACE=( III IV V VI VII VIII )

# bspc wm -r
connected_monitors=$(xrandr --query | grep " connected" | awk '{ print $1 }')

if echo "$connected_monitors" | grep -q "$SECONDARY"; then
    for workspace in "${SECONDARY_WORKSPACE[@]}"; do
        bspc desktop ${workspace} --to-monitor ${SECONDARY}
    done
else
    # Create a temporary desktop on the secondary monitor
    temp_desktop=$(bspc monitor "${SECONDARY}" -a TEMP)
    # Secondary monitor is unplugged: move workspaces
    for workspace in "${SECONDARY_WORKSPACE[@]}"; do
        bspc desktop ${workspace} --to-monitor ${PRIMARY}
        bspc desktop -f ${workspace}
        sleep 1
    done
fi
bspc desktop TEMP --remove
