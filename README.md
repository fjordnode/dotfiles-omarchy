# Omarchy Dotfiles

My personal configuration for [Omarchy](https://omarchy.dev) - a Hyprland-based Arch Linux setup.

## What's Included

- **hypr/** - Hyprland keybindings and monitor config (4K @ 144Hz)
- **ghostty/** - Ghostty terminal config with zsh as default shell
- **oh-my-posh/** - Custom prompt theme with dynamic colors
- **omarchy-hooks/** - Theme hook that syncs oh-my-posh colors with omarchy themes
- **zsh/** - Zsh local config with auto theme reload

## Features

- **Auto theme sync**: When you change themes in omarchy, all open terminal prompts update automatically
- **Suspend in power menu**: Added suspend option to the omarchy system menu
- **Zsh with oh-my-zsh**: Autosuggestions, syntax highlighting, and more

## Installation

```bash
git clone https://github.com/YOUR_USERNAME/dotfiles-omarchy.git ~/dotfiles-omarchy
cd ~/dotfiles-omarchy
./install.sh
```

## Dependencies

Installed automatically by `install.sh`:
- stow
- zsh
- oh-my-posh
- oh-my-zsh + plugins (autosuggestions, syntax-highlighting, completions, history-substring-search, fzf-tab)

## Manual Setup

If you prefer manual installation:

```bash
# Stow individual configs
cd ~/dotfiles-omarchy
stow -v --target=$HOME hypr
stow -v --target=$HOME ghostty
stow -v --target=$HOME oh-my-posh
stow -v --target=$HOME omarchy-hooks

# Link zshrc.local
ln -sf ~/dotfiles-omarchy/zsh/.zshrc.local ~/.zshrc.local
```

## Notes

- `monitors.conf` is configured for a 4K display at 1.33x scale - adjust for your setup
- The theme sync uses FIFOs in `/tmp/zsh-reload-*` for IPC between shells
- Requires your main zshrc to source `~/.zshrc.local`
