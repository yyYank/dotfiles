#!/usr/bin/env bash
set -euo pipefail

if ! command -v pacman >/dev/null 2>&1; then
  echo "pacman not found. This script is for Arch Linux." >&2
  exit 1
fi

install_pacman() {
  sudo pacman --needed -S "$@"
}

# General CLI
install_pacman git tmux xsel fzf ripgrep tree ghq bat

# Editor / build tools
install_pacman ctags gradle

# Shell
install_pacman zsh zsh-completions zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting z

# DB CLI
install_pacman pgcli mycli

# Language runtimes / package managers
install_pacman go python nodejs npm yarn

# Others
install_pacman ctop lazydocker redis ttf-hack-nerd

# npm global tools
npm install -g gtop spaceship-prompt typescript
