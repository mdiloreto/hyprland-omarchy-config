#!/bin/bash
set -euo pipefail

ghostty &
/opt/google/chrome/google-chrome --app=https://chat.openai.com &
