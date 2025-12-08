# Workspace Autostart & Window Rules

- Reload after changes: `hyprctl reload`.

## Autostart (empty workspace hook)
- Defined in `workspaces_layout.conf`.
- Example: `workspace = 1, on-created-empty:bash /home/mdiloreto/.config/hypr/layouts/ws_1.sh`
  - Fires the first time workspace 1 is created and empty after login/reload.
  - Suppress by setting `HYPR_DISABLE_AUTOSTART=1` or touching `~/.config/hypr/autostart.disabled`.

## Window rules in use
- `windowrulev2 = workspace 1, class:^(?i)code$`
  - Sends VS Code windows to workspace 1.
- `windowrulev2 = fullscreen, class:^(?i)code$, workspace:1`
  - Makes VS Code fullscreen only on workspace 1.
- `windowrulev2 = group set always, class:^(chrome-(calendar|mail)\.google\.com__-Default)$`
  - Auto-groups Calendar + Gmail PWAs wherever they open.
- `windowrulev2 = group set always, class:^(chrome-(open\.spotify|web\.whatsapp)\.com__-Default)$`
  - Auto-groups Spotify + WhatsApp PWAs wherever they open.

## Notes & tips
- Rules match the window class/app_id, not the process name. Inspect with:  
  `hyprctl clients -j | jq -r '.[] | [.class, .title] | @tsv'`
- Grouping applies only to new windows; close/reopen the apps to regroup after rule edits.
- To add more grouped apps (e.g., YouTube PWA), duplicate the workspace 8 lines with the exact class reported by `hyprctl clients -j`.
- Regex reminders (Hyprland uses PCRE):
  - `^` / `$` anchor the whole string; escape dots `\.` to match literal dots.
  - `(?i)` makes a pattern case-insensitive (used for `code`).
  - Group alternates with `(...)|(...)` like `chrome-(calendar|mail)\.google\.com__-Default`.
