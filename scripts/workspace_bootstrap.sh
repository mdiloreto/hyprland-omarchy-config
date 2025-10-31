#!/bin/bash
set -euo pipefail

# Prevent workspaces from relaunching their apps every time they go empty.
# Each workspace layout script will only run once per Hyprland session unless
# HYPR_BOOTSTRAP_FORCE=1 is provided.

workspace_id="${1:-}"
if [[ -z "${workspace_id}" ]]; then
    echo "workspace_bootstrap: workspace id required" >&2
    exit 1
fi

layout_script="${HOME}/.config/hypr/layouts/ws_${workspace_id}.sh"
if [[ ! -x "${layout_script}" ]]; then
    echo "workspace_bootstrap: missing launcher ${layout_script}" >&2
    exit 0
fi

state_root="${XDG_RUNTIME_DIR:-/tmp}/hypr-workspace-bootstrap"
mkdir -p "${state_root}"
state_file="${state_root}/ws_${workspace_id}"

if [[ -f "${state_file}" && "${HYPR_BOOTSTRAP_FORCE:-0}" != "1" ]]; then
    exit 0
fi

bash "${layout_script}"
touch "${state_file}"
