#!/bin/bash
set -euo pipefail

AUTOSTART_FLAG="${HOME}/.config/hypr/autostart.disabled"

if [[ "${HYPR_DISABLE_AUTOSTART:-0}" == "1" || -f "${AUTOSTART_FLAG}" ]]; then
    exit 0
fi

# Launch first app and wait for window
$HOME/.local/bin/chromium --app=https://open.spotify.com &
sleep 2

# Create group on the Spotify window
hyprctl dispatch togglegroup

# Launch second app (will auto-join via group set always rule)
$HOME/.local/bin/chromium --app=https://web.whatsapp.com &