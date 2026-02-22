#!/bin/bash
set -e

# --- mise (ランタイム + CLIツール) ---
if ! command -v mise &>/dev/null; then
    echo "mise not found, install: https://mise.jdx.dev"
    exit 1
fi

mise use --global go@latest
mise use --global node@20
mise use --global vim@latest
mise use --global tmux@latest
mise use --global fzf@latest
mise use --global ripgrep@latest

# --- brew (mise にないもの) ---
if ! command -v brew &>/dev/null; then
    echo "brew not found"
    exit 1
fi

brew install git
brew install reattach-to-user-namespace

# zsh plugins
brew install zsh-autosuggestions
brew install zsh-history-substring-search
brew install zsh-syntax-highlighting
brew install zsh-completions

# cask
brew install --cask font-hack-nerd-font

# diff-highlight
if [ ! -f /usr/local/bin/diff-highlight ]; then
    sudo ln -s /usr/local/share/git-core/contrib/diff-highlight/diff-highlight /usr/local/bin/diff-highlight
fi

# --- go install ---
go install github.com/gokcehan/lf@latest
go install github.com/x-motemen/ghq@latest
go install github.com/alecthomas/chroma/v2/cmd/chroma@latest

# --- npm install -g ---
npm install -g spaceship-prompt
npm install -g ccusage
