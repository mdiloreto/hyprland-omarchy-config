#!/bin/bash
LAYOUT_DIR="/home/mdiloreto/.config/hypr/layouts"
LAYOUT_CONF="/home/mdiloreto/.config/hypr/workspaces_layout.conf"

mkdir -p "$LAYOUT_DIR"
rm -f "$LAYOUT_DIR"/*
> "$LAYOUT_CONF"

declare -A workspace_pids
# Create an associative array to store PIDs for each workspace
while IFS=: read -r workspace_id pid; do
    workspace_pids["$workspace_id"]+="$pid "
done < <(hyprctl -j clients | jq -r '.[] | select(.pid != -1) | "\(.workspace.id):\(.pid)"')

for ws_id in "${!workspace_pids[@]}"; do
    ws_script="$LAYOUT_DIR/ws_$ws_id.sh"
    echo "#!/bin/bash" > "$ws_script"
    
    # Create a sub-script for each workspace
    for pid in ${workspace_pids[$ws_id]}; do
        # Get command from /proc/<pid>/cmdline, handle null separators
        cmdline=$(tr '\0' ' ' < "/proc/$pid/cmdline")
        # Add command to the script, run in background
        echo "$cmdline &" >> "$ws_script"
    done
    
    chmod +x "$ws_script"
    echo "workspace = $ws_id, on-created-empty:bash $ws_script" >> "$LAYOUT_CONF"
done
