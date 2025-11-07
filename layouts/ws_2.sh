#!/bin/bash
set -euo pipefail

warp-terminalwar &
chromium --app=https://chat.openai.com &
