#!/bin/env bash
WALLPAPER_DIR="$HOME/Photo/Wallpaper"

while true; do
    NEW_WALLPAPER="$(find "$WALLPAPER_DIR" -type f | shuf -n 1)"
    swaymsg "output * bg $NEW_WALLPAPER fill"
    sleep 600
done
