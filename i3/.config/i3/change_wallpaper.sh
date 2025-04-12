#!/bin/bash

# Directory containing wallpapers
WALLPAPER_DIR="$HOME/.config/backgrounds/"

# Select a random file from the directory
WALLPAPER=$(ls "$WALLPAPER_DIR" | shuf -n 1)

# Set the wallpaper using feh
feh --bg-fill $WALLPAPER_DIR/$WALLPAPER
