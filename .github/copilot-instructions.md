## Purpose

This repository contains a single, self-contained Zsh-based alias manager script used to create, remove, list, search and edit shell aliases.

Use these instructions to help AI coding agents be immediately productive when editing or extending this project.

## Big picture

- Single-file, small CLI implemented as a Zsh script: `aliasEngine.zsh`.
- Two writable runtime paths declared at the top of the script:
  - `ALIAS_FILE="$HOME/.config/zsh/alias.zsh"` — the persistent alias store.
  - `ALIAS_ENGINE="$HOME/.config/zsh/aliasEngine.zsh"` — the script file itself (used by `eae`).
- Behavior: commands append or remove `alias name='command'` lines in `ALIAS_FILE` and try to apply changes to the current shell immediately (via `alias` and `unalias`).

## Key commands and examples (real from code)

- Show help: `ae`
- Create alias: `newae <name> <command>`
  - Example: `newae ll "ls -la"`
  - Notes: the function expands `~` to `$HOME` before writing. The file write is append-only after removing an existing `alias <name>=` line.
- Remove alias: `rmae <name>`
- List aliases: `lsae` (uses `grep '^alias ' "$ALIAS_FILE" | sed 's/alias //' | column -t -s "="`)
- Search aliases: `fae <pattern>`
- Edit engine: `eae` opens `nvim "${ALIAS_ENGINE}"` and then `source`-s it.

## Project-specific conventions & gotchas

- The script uses macOS/BSD `sed -i ''` style in-place edits — preserve this when modifying sed invocations for compatibility with macOS.
- `eae` explicitly invokes `nvim` (not `$EDITOR`). If you add editor flexibility, update `eae` accordingly.
- Function naming is short (ae, newae, rmae, lsae, fae, eae). Keep that pattern when adding helpers.
- The alias store is a plain shell file with lines like `alias name='cmd'`. Tools should manipulate that format (match `^alias <name>=`).

## What to change and how to test locally

- To run and iterate locally:
  1. Source the script in your current shell: `source /path/to/aliasEngine.zsh` (or add `source "$HOME/.config/zsh/aliasEngine.zsh"` to your `.zshrc`).
  2. Test adding an alias: `newae test_alias "date"` then run `test_alias`.
  3. Verify listing: `lsae` and searching: `fae test_alias`.
  4. Remove: `rmae test_alias` and confirm with `lsae`.

## Integration points & assumptions

- This script expects a writable `~/.config/zsh/alias.zsh` file. If it doesn't exist, create it with `mkdir -p ~/.config/zsh && touch ~/.config/zsh/alias.zsh`.
- It uses built-in shell commands (`alias`, `unalias`, `sed`, `grep`, `column`) — changes should preserve POSIX-compatibility where possible.

## Guidance for AI edits

- Make minimal, focused changes: this repo is intentionally simple. Prefer changes that keep the one-file engine model.
- When editing functions, preserve the `ALIAS_FILE` and `ALIAS_ENGINE` variables and update usages consistently.
- If adding features that change the on-disk format, include a small migration in the script and add clear help text.
- Include small, executable examples in PR descriptions (copy the 4-step local test above) so reviewers can validate behavior quickly.

## Files to reference

- `aliasEngine.zsh` — main script, the single source of truth for behavior and command names.
- `README.md` — brief project description; expand if you add features.

## If anything is unclear

Ask for specifics about desired behavior (for example: alias value quoting rules, editor preferences, or cross-shell support). If you want, I can also implement an `--editor` or `$EDITOR` fallback and add a quick test harness.
