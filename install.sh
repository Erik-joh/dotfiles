#!/bin/bash
DOTFILES="$(cd "$(dirname "$0")" && pwd)"
BACKUP_DIR="$HOME/.dotfiles_backup/$(date +%Y%m%d_%H%M%S)"

# Files that stow will manage
STOW_FILES=(
    ".zshrc"
    ".aliases"
    ".profile"
    ".config/wezterm/wezterm.lua"
    ".config/aerospace/aerospace.toml"
)

# Back up existing files
echo "Backing up existing dotfiles to $BACKUP_DIR"
mkdir -p "$BACKUP_DIR"

for file in "${STOW_FILES[@]}"; do
    if [ -f "$HOME/$file" ] && [ ! -L "$HOME/$file" ]; then
        mkdir -p "$BACKUP_DIR/$(dirname "$file")"
        mv "$HOME/$file" "$BACKUP_DIR/$file"
        echo "Backed up $file"
    fi
done

# Also back up vscode (manual symlinks)
for vscode_file in settings.json keybindings.json; do
    if [[ "$OSTYPE" == "darwin"* ]]; then
        VSCODE_DIR="$HOME/Library/Application Support/Code/User"
    else
        VSCODE_DIR="$HOME/.config/Code/User"
    fi
    if [ -f "$VSCODE_DIR/$vscode_file" ] && [ ! -L "$VSCODE_DIR/$vscode_file" ]; then
        mkdir -p "$BACKUP_DIR/vscode"
        mv "$VSCODE_DIR/$vscode_file" "$BACKUP_DIR/vscode/$vscode_file"
        echo "Backed up vscode/$vscode_file"
    fi
done

# Install stow if not present
if ! command -v stow &> /dev/null; then
    echo "Installing stow..."
    if [[ "$OSTYPE" == "darwin"* ]]; then
        brew install stow
    else
        sudo apt install stow
    fi
fi

cd "$DOTFILES"

# Stow platform-independent packages
stow -v zsh
stow -v scripts
stow -v wezterm

# macOS only
if [[ "$OSTYPE" == "darwin"* ]]; then
    stow -v aerospace
fi

# VS Code: detect OS and symlink from single source
if [[ "$OSTYPE" == "darwin"* ]]; then
    VSCODE_DIR="$HOME/Library/Application Support/Code/User"
else
    VSCODE_DIR="$HOME/.config/Code/User"
fi

mkdir -p "$VSCODE_DIR"
ln -sf "$DOTFILES/vscode/settings.json" "$VSCODE_DIR/settings.json"
ln -sf "$DOTFILES/vscode/keybindings.json" "$VSCODE_DIR/keybindings.json"

# Make scripts executable
chmod +x "$HOME/.local/bin/"**/*.sh

# Secrets: copy template if needed
if [ ! -f "$HOME/.zshrc_secrets" ]; then
    cp "$DOTFILES/secrets/.zshrc_secrets.template" "$HOME/.zshrc_secrets"
    echo "Created ~/.zshrc_secrets — fill in your secrets!"
fi

echo "Done!"