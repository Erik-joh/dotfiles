#!/bin/bash
DOTFILES="$(cd "$(dirname "$0")" && pwd)"

# Detect OS
if [[ "$OSTYPE" == "darwin"* ]]; then
    OS="mac"
else
    OS="linux"
fi

# Install Homebrew (macOS) or apt dependencies (Linux)
if [ "$OS" = "mac" ]; then
    if ! command -v brew &> /dev/null; then
        echo "Installing Homebrew..."
        /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
    fi
    echo "Installing brew packages..."
    brew bundle --file="$DOTFILES/Brewfile"
else
    echo "Installing apt packages..."
    sudo apt update
    sudo apt install -y \
        jq \
        neovim \
        stow \
        zsh
    # Add any Linux-specific installs here
fi

# Oh My Zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    echo "Installing Oh My Zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# NVM
if [ ! -d "$HOME/.nvm" ]; then
    echo "Installing NVM..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.1/install.sh | bash
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && source "$NVM_DIR/nvm.sh"
    nvm install --lts
fi

# VS Code extensions
if command -v code &> /dev/null; then
    echo "Installing VS Code extensions..."
    while read -r ext; do
        code --install-extension "$ext"
    done < "$DOTFILES/vscode/extensions.txt"
fi

# macOS only
if [ "$OS" = "mac" ]; then
    echo "Applying macOS settings..."
    # Example: faster key repeat, show hidden files, etc.
    # defaults write NSGlobalDomain KeyRepeat -int 2
    # defaults write com.apple.finder AppleShowAllFiles -bool true
    defaults write NSGlobalDomain KeyRepeat -int 2
    defaults write NSGlobalDomain InitialKeyRepeat -int 15
    defaults write com.apple.dock autohide -bool true
    defaults write com.apple.dock tilesize -int 36
    defaults write NSGlobalDomain com.apple.swipescrolldirection -bool false
    defaults write com.apple.dock mru-spaces -bool false
    defaults write NSGlobalDomain ApplePressAndHoldEnabled -bool false
    defaults write com.apple.universalaccess reduceMotion -bool true
    # Restart Dock to apply changes
    killall Dock
fi

echo "Setup complete!"