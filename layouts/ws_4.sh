#!/bin/bash
set -euo pipefail

AUTOSTART_FLAG="${HOME}/.config/hypr/autostart.disabled"

if [[ "${HYPR_DISABLE_AUTOSTART:-0}" == "1" || -f "${AUTOSTART_FLAG}" ]]; then
    exit 0
fi

# No autostart applications configured for this workspace.
$HOME/.local/bin/chromium &
$HOME/.local/bin/chromium --app=https://chat.openai.com &
