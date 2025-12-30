#!/bin/bash

set -euo pipefail

CURRENT=$(hyprctl activeworkspace -j | jq '.id')
MOVE=$1
NEXT=$((CURRENT + MOVE))

if (( NEXT > 0 && NEXT < 13 )); then
    hyprctl dispatch workspace $NEXT
fi
