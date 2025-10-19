#!/bin/bash

# Get a list of all window addresses in JSON format
WINDOW_INFO=$(hyprctl clients -j)

# Iterate through each window and dispatch a closewindow command
echo "$WINDOW_INFO" | jq -r '.[].address' | while read -r address; do
    echo "Attempting to close window: $address"
    hyprctl dispatch closewindow "$address"
done

# Shutdown the system
shutdown now
