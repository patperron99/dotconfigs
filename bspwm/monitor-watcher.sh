#!/bin/bash

# Detect monitor changes
xrandr | grep " connected" | awk '{ print $1 }' > /tmp/monitors_before

while true; do
    sleep 1
    xrandr | grep " connected" | awk '{ print $1 }' > /tmp/monitors_now

    if ! diff /tmp/monitors_before /tmp/monitors_now &>/dev/null; then
        bash ~/.config/bspwm/detect_monitor.sh
        cp /tmp/monitors_now /tmp/monitors_before
    fi
done
