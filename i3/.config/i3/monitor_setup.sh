#!/bin/bash

# Define monitor names
PRIMARY="eDP-1"
SECONDARY="DP-3"

is_mode_exist=$(xrandr | grep "1920x1080R")
if [ -z "$is_mode_exist" ]; then
    xrandr --newmode "1920x1080R"  138.50  1920 1968 2000 2080  1080 1083 1088 1111 +hsync -vsync
    xrandr --addmode DP-3 1920x1080R
fi


# Check if the secondary monitor is connected
if xrandr | grep "^$SECONDARY connected"; then
    # Configure the secondary monitor to the right of the primary
    xrandr --output "$SECONDARY" --auto --right-of "$PRIMARY"
    # Set the mode of the secondary monitor
    xrandr --output DP-3 --mode 1920x1080R
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

