#!/bin/bash

# Define monitor names
PRIMARY="eDP-1"
SECONDARY="DP-3"

# Check if the secondary monitor is connected
if xrandr | grep "^$SECONDARY connected"; then
    # Configure the secondary monitor to the right of the primary
    xrandr --output "$SECONDARY" --auto --right-of "$PRIMARY"

    # Assign workspaces 4-9 to the secondary monitor
    for i in {4..9}; do
        i3-msg "workspace $i; move workspace to output $SECONDARY"
    done
else
    # Turn off the secondary monitor if it's disconnected
    xrandr --output "$SECONDARY" --off

    # Assign workspaces 4-9 to the primary monitor
    for i in {4..9}; do
        i3-msg "workspace $i; move workspace to output $PRIMARY"
    done
fi

