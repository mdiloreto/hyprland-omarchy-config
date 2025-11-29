#!/bin/bash
set -euo pipefail

AUTOSTART_FLAG="${HOME}/.config/hypr/autostart.disabled"

if [[ "${HYPR_DISABLE_AUTOSTART:-0}" == "1" || -f "${AUTOSTART_FLAG}" ]]; then
    exit 0
fi

chromium --app=https://calendar.google.com &
chromium --app=https://mail.google.com &
