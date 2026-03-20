# dotfiles

macOS-focused dotfiles managed with [GNU Stow](https://www.gnu.org/software/stow/). Configs for Zsh, Neovim, Wezterm, Aerospace, VS Code, Lazygit, and OpenCode. Linux is partially supported.

## What's Included

| Tool          | Config Location                                          | Highlights                                                                |
| ------------- | -------------------------------------------------------- | ------------------------------------------------------------------------- |
| **Zsh**       | `zsh/.zshrc`, `zsh/.aliases`                             | Oh My Zsh, autosuggestions, syntax highlighting, history substring search |
| **Neovim**    | `nvim/.config/nvim/`                                     | Lazy.nvim plugin manager, LSP, Treesitter, Harpoon, Oil, Snacks           |
| **Wezterm**   | `wezterm/.config/wezterm/wezterm.lua`                    | Tokyo Night theme, JetBrains Mono, Vim-style splits                       |
| **Aerospace** | `aerospace/.config/aerospace/aerospace.toml`             | i3-like tiling WM for macOS, Alt+hjkl focus, workspace switching          |
| **VS Code**   | `vscode/settings.json`, `vscode/keybindings.json`        | One Dark Pro, vscodevim, JetBrains Mono                                   |
| **Lazygit**   | `lazygit/Library/Application Support/lazygit/config.yml` | Custom lazygit configuration                                              |
| **OpenCode**  | `opencode/.config/opencode/config.json`                  | OpenCode CLI configuration                                                |

## Prerequisites

- macOS (primary) or Linux
- [Homebrew](https://brew.sh/) (macOS)
- Git

## Quick Start

```bash
# Clone the repo
git clone <your-repo-url> ~/dotfiles
cd ~/dotfiles

# Install dependencies (Homebrew packages, Oh My Zsh, NVM, VS Code extensions, macOS settings)
./setup.sh

# Deploy configs via symlinks (backs up existing dotfiles first)
./install.sh
```

## How It Works

### Stow-based Layout

Each tool has its own directory that mirrors the target filesystem structure relative to `~`. GNU Stow creates symlinks from these directories into your home directory.

```
dotfiles/
├── zsh/.zshrc                → ~/.zshrc
├── zsh/.aliases              → ~/.aliases
├── nvim/.config/nvim/        → ~/.config/nvim/
├── wezterm/.config/wezterm/  → ~/.config/wezterm/
├── aerospace/.config/aerospace/ → ~/.config/aerospace/
├── opencode/.config/opencode/   → ~/.config/opencode/
└── lazygit/Library/...       → ~/Library/Application Support/lazygit/
```

VS Code configs are symlinked manually (not via Stow) to `~/Library/Application Support/Code/User/`.

### Secrets

Sensitive environment variables live in `~/.zshrc_secrets`, which is git-ignored. A template is provided at `secrets/.zshrc_secrets.template` and will be copied on first install.

## Adding a New Tool

1. Create a directory matching the tool name
2. Mirror the target path inside it (e.g., `newtool/.config/newtool/config.toml`)
3. Add a `stow newtool` call in `install.sh`

## Brewfile

All Homebrew packages are declared in `Brewfile`. To install everything:

```bash
brew bundle
```

