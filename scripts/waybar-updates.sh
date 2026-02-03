#!/bin/bash

# Define Omarchy path
OMARCHY_PATH="${OMARCHY_PATH:-$HOME/.local/share/omarchy}"

# Initialize variables
TOOLTIP_ENTRIES=()
HAS_UPDATES=false

# 1. Check Omarchy updates
if [ -d "$OMARCHY_PATH" ]; then
    # Use ls-remote as in the original script to check remote tags without fetching everything
    latest_tag=$(git -C "$OMARCHY_PATH" ls-remote --tags origin | grep -v "{}" | awk '{print $2}' | sed 's#refs/tags/##' | sort -V | tail -n 1)
    current_tag=$(git -C "$OMARCHY_PATH" describe --tags $(git -C "$OMARCHY_PATH" rev-list --tags --max-count=1))
    
    if [[ -n "$latest_tag" && -n "$current_tag" && "$current_tag" != "$latest_tag" ]]; then
        TOOLTIP_ENTRIES+=("Omarchy: $current_tag -> $latest_tag")
        HAS_UPDATES=true
    fi
fi

# 2. Check system updates
# Check for updates in local DB (assumes DB is synced by other means or user)
PKG_UPDATES=$(yay -Qu 2>/dev/null | wc -l)

if [ "$PKG_UPDATES" -gt 0 ]; then
    TOOLTIP_ENTRIES+=("Packages: $PKG_UPDATES updates available")
    HAS_UPDATES=true
fi

# 3. Output JSON
if [ "$HAS_UPDATES" = true ]; then
    # Join tooltip entries with newline
    TOOLTIP=$(IFS=$'\n'; echo "${TOOLTIP_ENTRIES[*]}")
    # Escape newlines for JSON
    TOOLTIP="${TOOLTIP//$'\n'/\\n}"
    # Output JSON with icon
    printf '{"text": "", "tooltip": "%s", "class": "updates"}\n' "$TOOLTIP"
else
    # Output empty text to hide module
    printf '{"text": "", "tooltip": "System is up to date", "class": "up-to-date"}\n'
fi
