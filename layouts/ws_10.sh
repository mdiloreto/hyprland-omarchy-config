#!/bin/bash
set -euo pipefail

AUTOSTART_FLAG="${HOME}/.config/hypr/autostart.disabled"

if [[ "${HYPR_DISABLE_AUTOSTART:-0}" == "1" || -f "${AUTOSTART_FLAG}" ]]; then
    exit 0
fi

# Launch first app and wait for window to appear
$HOME/.local/bin/chromium --app=https://calendar.google.com &

# Wait until calendar window exists (max 10 seconds)
for i in {1..20}; do
    if hyprctl clients -j | jq -e '.[] | select(.class | test("calendar"))' > /dev/null 2>&1; then
        break
    fi
    sleep 0.5
done
sleep 0.5

# Create group on the Calendar window
hyprctl dispatch togglegroup

# Launch second app (will auto-join via group set always rule)
$HOME/.local/bin/chromium --app=https://mail.google.com &
