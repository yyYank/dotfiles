# dotfiles

## 対応 OS

- macOS
- Arch Linux

## 管理対象

| カテゴリ | 対象ファイル |
|---------|------------|
| シェル | `.zshrc`, `.zsh/functions.zsh` |
| エディタ | `.vimrc`, `.vim/`, `.ideavimrc` |
| ターミナル | `.tmux.conf` |
| ファイラ | `.config/lf/lfrc`, `.config/lf/preview.sh` |
| Git | `.gitconfig`, `git/config.*` |
| Claude Code | `.claude/hooks/update-status.sh`, `claude/settings.json`, `claude/skills/` |
| Codex | `codex/AGENTS.md`, `codex/rules/`, `codex/skills/`, `setup/sync-codex.sh` |
| Arch 固有 | `.xmonad/`, `.xmobarrc`, `.Xresources`, `.xinitrc` |
| セットアップ | `setup/tool-install.sh` |

## 要求ライブラリ / ツール

| ツール | 用途 |
|-------|------|
| [Homebrew](https://brew.sh/) | パッケージ管理 (macOS) |
| [tmux](https://github.com/tmux/tmux) | ターミナルマルチプレクサ |
| [vim](https://www.vim.org/) | エディタ |
| [lf](https://github.com/gokcehan/lf) | ターミナルファイラ |
| [bat](https://github.com/sharkdp/bat) | シンタックスハイライト |
| [fzf](https://github.com/junegunn/fzf) | ファジーファインダー |
| [ghq](https://github.com/x-motemen/ghq) | リポジトリ管理 |
| [mise](https://github.com/jdx/mise) | ランタイムバージョン管理 |
| [spaceship-prompt](https://github.com/spaceship-prompt/spaceship-prompt) | zsh プロンプト |
| [ccusage](https://github.com/ryoppippi/ccusage) | Claude Code 使用状況取得 |
| zsh-autosuggestions, zsh-syntax-highlighting, zsh-history-substring-search | zsh プラグイン |
