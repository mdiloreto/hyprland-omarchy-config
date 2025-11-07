#!/bin/bash
set -euo pipefail


chromium --app=https://calendar.google.com &
chromium --app=https://mail.google.com &