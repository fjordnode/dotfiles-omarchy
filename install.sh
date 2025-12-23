#!/bin/bash

set -e

echo "==> Installing omarchy dotfiles..."

# Check for stow
if ! command -v stow &> /dev/null; then
    echo "Installing stow..."
    sudo pacman -S --noconfirm stow
fi

# Check for zsh dependencies
echo "==> Checking zsh dependencies..."
if ! command -v zsh &> /dev/null; then
    sudo pacman -S --noconfirm zsh
fi

if ! command -v oh-my-posh &> /dev/null; then
    echo "Installing oh-my-posh..."
    sudo pacman -S --noconfirm oh-my-posh
fi

# Install oh-my-zsh if not present
if [[ ! -d ~/.oh-my-zsh ]]; then
    echo "Installing oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended
fi

# Install zsh plugins
ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"
declare -A plugins=(
    ["zsh-autosuggestions"]="https://github.com/zsh-users/zsh-autosuggestions"
    ["zsh-syntax-highlighting"]="https://github.com/zsh-users/zsh-syntax-highlighting"
    ["zsh-completions"]="https://github.com/zsh-users/zsh-completions"
    ["history-substring-search"]="https://github.com/zsh-users/zsh-history-substring-search"
    ["fzf-tab"]="https://github.com/Aloxaf/fzf-tab"
)

for plugin in "${!plugins[@]}"; do
    if [[ ! -d "$ZSH_CUSTOM/plugins/$plugin" ]]; then
        echo "Installing $plugin..."
        git clone "${plugins[$plugin]}" "$ZSH_CUSTOM/plugins/$plugin"
    fi
done

# Stow all configs
cd "$(dirname "$0")"
echo "==> Stowing configs..."

for dir in hypr ghostty oh-my-posh omarchy-hooks; do
    echo "  Stowing $dir..."
    stow -v --target="$HOME" "$dir"
done

# Handle zshrc.local separately (not stow, just copy/link)
if [[ -f ~/.zshrc.local ]]; then
    echo "  Backing up existing .zshrc.local..."
    mv ~/.zshrc.local ~/.zshrc.local.backup
fi
ln -sf "$(pwd)/zsh/.zshrc.local" ~/.zshrc.local

echo ""
echo "==> Done! Restart your terminals or run 'exec zsh'"
echo ""
echo "Note: Your monitors.conf may need adjusting for your display."
echo "Edit ~/.config/hypr/monitors.conf as needed."
