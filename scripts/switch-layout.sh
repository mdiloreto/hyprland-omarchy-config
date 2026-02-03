#!/bin/bash
# Switch keyboard layout for all keyboards
hyprctl devices -j | jq -r '.keyboards[].name' | while read -r name; do
    hyprctl switchxkblayout "$name" next
done

# Get current layout name (from the first keyboard)
CURRENT=$(hyprctl devices -j | jq -r '.keyboards[0].active_keymap')
notify-send -t 2000 "Keyboard Layout" "Switched to: $CURRENT"
