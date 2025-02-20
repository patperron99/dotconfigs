#!/bin/bash

# get active workspace
active_workspace=$(i3-msg -t get_workspaces | jq -r '.[] | select(.focused==true).name')

DEVICE_TYPE=$(hostnamectl chassis)
if [[ "$DEVICE_TYPE" == "notebook" || "$DEVICE_TYPE" == "laptop" ]]; then
    DEVICE_TYPE="laptop"
    PRIMARY="eDP-1"
    SECONDARY="DP-3"

else
    DEVICE_TYPE="desktop"
    PRIMARY="DisplayPort-2"
    SECONDARY="HDMI-A-0"
fi


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
    xrandr --output "$SECONDARY" --mode 1920x1080R
    # Assign workspaces 1-3 to the primary monitor
    for i in {1..3}; do
        i3-msg "workspace $i; move workspace to output $PRIMARY"
    done
   # Assign workspaces 4-9 to the secondary monitor
    for i in {4..10}; do
        i3-msg "workspace $i; move workspace to output $SECONDARY"
    done
else
    # Turn off the secondary monitor if it's disconnected
    xrandr --output "$SECONDARY" --off

    # Assign workspaces 4-9 to the primary monitor
    for i in {1..10}; do
        i3-msg "workspace $i; move workspace to output $PRIMARY"
    done
fi

# Move the active workspace back to the primary monitor
i3-msg "workspace $active_workspace"
