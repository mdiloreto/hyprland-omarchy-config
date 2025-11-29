#!/bin/bash
set -euo pipefail

STATE_FILE="${HOME}/.config/hypr/autostart.disabled"
WAYBAR_SIGNAL="${WAYBAR_SIGNAL:-9}"

emit_status() {
    if [[ -f "${STATE_FILE}" ]]; then
        printf '{"text":"󰾆","tooltip":"Autostart disabled (Course Mode)","class":"disabled"}\n'
    else
        printf '{"text":"󰐱","tooltip":"Autostart enabled","class":"enabled"}\n'
    fi
}

send_signal() {
    pkill -RTMIN+"${WAYBAR_SIGNAL}" waybar 2>/dev/null || true
}

case "${1:-status}" in
status)
    emit_status
    ;;
toggle)
    if [[ -f "${STATE_FILE}" ]]; then
        rm -f "${STATE_FILE}"
    else
        touch "${STATE_FILE}"
    fi
    send_signal
    ;;
*)
    echo "Usage: $0 [status|toggle]" >&2
    exit 1
    ;;
esac
