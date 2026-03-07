#!/usr/bin/env bash
set -euo pipefail

if ! command -v pacman >/dev/null 2>&1; then
  echo "pacman not found. This script is for Arch Linux." >&2
  exit 1
fi

install_pacman() {
  if command -v sudo >/dev/null 2>&1; then
    sudo pacman --noconfirm --needed -S "$@"
  else
    pacman --noconfirm --needed -S "$@"
  fi
}

install_if_available() {
  local install_list=()
  local skipped_list=()
  local pkg

  for pkg in "$@"; do
    if pacman -Si "$pkg" >/dev/null 2>&1; then
      install_list+=("$pkg")
    else
      skipped_list+=("$pkg")
    fi
  done

  if [ "${#install_list[@]}" -gt 0 ]; then
    install_pacman "${install_list[@]}"
  fi

  if [ "${#skipped_list[@]}" -gt 0 ]; then
    echo "Skipping unavailable packages: ${skipped_list[*]}" >&2
  fi
}

# General CLI
install_if_available git tmux xsel fzf ripgrep tree ghq bat

# Editor / build tools
install_if_available ctags gradle

# Shell
install_if_available zsh zsh-completions zsh-autosuggestions zsh-history-substring-search zsh-syntax-highlighting z

# DB CLI
install_if_available pgcli mycli

# Language runtimes / package managers
install_if_available go python nodejs npm yarn

# Others
install_if_available ctop lazydocker redis ttf-hack-nerd

# npm global tools
npm install -g gtop spaceship-prompt typescript
