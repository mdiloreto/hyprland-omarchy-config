#!/bin/bash
set -euo pipefail

export PATH="/usr/local/bin:/usr/bin:/bin${PATH:+:$PATH}"

LOG_DIR="${XDG_STATE_HOME:-$HOME/.local/state}/hypr"
mkdir -p "${LOG_DIR}"

AUTOSTART_FLAG="${HOME}/.config/hypr/autostart.disabled"

if [[ "${HYPR_DISABLE_AUTOSTART:-0}" == "1" || -f "${AUTOSTART_FLAG}" ]]; then
    exit 0
fi

echo "$(date '+%F %T') ws1 autostart" >> "${LOG_DIR}/workspace-hooks.log"

if command -v code >/dev/null 2>&1; then
    code &
fi
