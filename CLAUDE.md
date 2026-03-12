# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Overview

macOS-focused dotfiles repo managing configs for zsh, VS Code, Wezterm, and Aerospace via GNU Stow symlinks. Linux is partially supported.

## Setup Commands

```bash
# Install dependencies (Homebrew, Oh My Zsh, NVM, VS Code extensions, macOS settings)
./install.sh

# Deploy configs via symlinks (backs up existing dotfiles first)
./setup.sh
```

`setup.sh` uses `stow` to symlink directories (`zsh/`, `scripts/`, `wezterm/`, `aerospace/`) into `~`, and manually symlinks VS Code settings/keybindings.

## Architecture

### Stow-based layout
Each tool has its own directory mirroring the target filesystem structure relative to `~`. For example:
- `wezterm/.config/wezterm/wezterm.lua` → `~/.config/wezterm/wezterm.lua`
- `aerospace/.config/aerospace/aerospace.toml` → `~/.config/aerospace/aerospace.toml`
- `zsh/.zshrc` → `~/.zshrc`

VS Code configs are symlinked manually (not via stow) to `~/Library/Application Support/Code/User/`.

### Secrets
`.zshrc` sources `~/.zshrc_secrets` (git-ignored). Template at `secrets/.zshrc_secrets.template`.

## Key Configs

- **`zsh/.zshrc`** — Oh My Zsh (robbyrussell theme), NVM, Colima/Docker, auto-notify, syntax highlighting, history substring search
- **`wezterm/.config/wezterm/wezterm.lua`** — Tokyo Night theme, JetBrains Mono 18pt, Vim splits (Cmd+hjkl), WebGPU, tab bar at bottom
- **`aerospace/.config/aerospace/aerospace.toml`** — i3-like tiling WM; Alt+hjkl focus, Ctrl+1-9 workspaces
- **`vscode/settings.json`** — One Dark Pro Night Flat, vscodevim, JetBrains Mono 16pt
- **`Brewfile`** — All Homebrew packages; run `brew bundle` to install

## Adding a New Tool

1. Create a directory matching the tool name
2. Mirror the target path inside it (e.g., `newtool/.config/newtool/config.toml`)
3. Add a `stow newtool` call in `setup.sh`
