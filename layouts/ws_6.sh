#!/bin/bash
set -euo pipefail

if command -v warp-terminal >/dev/null 2>&1; then
    warp-terminal &
else
    /opt/warpdotdev/warp-terminal/warp &
fi
