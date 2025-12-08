#!/bin/bash
set -euo pipefail

export PATH="/usr/local/bin:/usr/bin:/bin:$PATH"

AUTOSTART_FLAG="${HOME}/.config/hypr/autostart.disabled"

if [[ "${HYPR_DISABLE_AUTOSTART:-0}" == "1" || -f "${AUTOSTART_FLAG}" ]]; then
    exit 0
fi

echo "$(date '+%F %T') ws1 autostart" >> /tmp/hypr-workspace-hooks.log

if command -v code >/dev/null 2>&1; then
    code &
fi
