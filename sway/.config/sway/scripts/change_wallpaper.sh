#!/bin/bash

# Directory containing wallpapers
WALLPAPER_DIR="$HOME/.config/backgrounds/"

# Select a random file from the directory
WALLPAPER=$(ls "$WALLPAPER_DIR" | shuf -n 1)

cp $WALLPAPER_DIR/$WALLPAPER $WALLPAPER_DIR/default
# Set the wallpaper using 
swaybg -i $WALLPAPER_DIR/$WALLPAPER
