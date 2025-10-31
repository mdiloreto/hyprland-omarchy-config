# Repository Guidelines

For overarching Omarchy conventions, review the root guide at `~/AGENTS.md` before contributing here.

## Project Structure & Module Organization
This Hyprland profile keeps user overrides in this directory while upstream defaults stay in ~/.local/share/omarchy/default. `hyprland.conf` only wires sources; edit the override files (`bindings.conf`, `monitors.conf`, `input.conf`, `envs.conf`, `looknfeel.conf`, `autostart.conf`, `workspaces_layout.conf`) to change behavior. Auxiliary scripts live under `scripts/`, per-workspace layouts in `layouts/`, and any TypeScript snippets belong in `typescript/`.

## Build, Reload, and Development Commands
Run `hyprctl reload` after editing configs to apply changes; it prints parse errors if syntax breaks. Use `hyprctl keyword <section> <value>` for quick experiments before committing lines to disk. Keep shell helpers executable with `chmod +x scripts/*.sh`, and when testing, launch apps through `uwsm app -- …` to mirror autostart behavior.

## Coding Style & Naming Conventions
Follow Hyprland's `key = value` spacing and group related directives with a blank line plus a comment header. Name bindings with descriptive labels (e.g., "Shutdown") and keep environment variables uppercase in `envs.conf`. Bash scripts should start with `#!/bin/bash`, enable `set -euo pipefail`, and use `snake_case` function names; prefer `jq` for JSON parsing as seen in `scripts/shutdown.sh`.

## Testing Guidelines
After reloading, verify outcomes with `hyprctl clients -j | jq '.'` or `hyprctl monitors` to confirm layout updates. For binding changes, exercise each key combo and watch `journalctl --user -u hyprland` for warnings. Run `shellcheck scripts/*.sh` and document manual test steps in commit messages when touching scripts.

## Commit & Pull Request Guidelines
Follow Conventional Commits (`feat:`, `fix:`, `chore:`) so diffs stay searchable; e.g., `feat(bindings): add workspace toggle shortcuts`. PRs should summarize the behavior change, note how it was validated (`hyprctl reload`, manual key checks), and include screenshots or logs when UI themes shift. Link related tickets or forum threads and call out any follow-up work needed.

## Security & Configuration Tips
Avoid checking secrets into `envs.conf`; source them from a local `.env` or systemd user service instead. When scripting shutdown or power actions, guard destructive commands behind confirmation flags so accidental binds cannot power off the machine. Document any host-specific paths to help other contributors adapt safely.
