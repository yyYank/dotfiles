source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source ~/.zsh/zsh-completions/zsh-completions.plugin.zsh
source ~/.zsh/z/z.sh
source /usr/local/share/zsh-history-substring-search/zsh-history-substring-search.zsh
export GOROOT=/usr/local/opt/go/libexec
export GOPATH=$HOME/go
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin
export PGDATA=/usr/local/var/postgres
fpath=(~/.zsh/zsh-completions/src $fpath)

#ANSI Color Constants
RED='\033[0;31m'
NC='\033[0m' # No Color
BLUE='\033[1;34m'
GREEN='\033[0;32m'

zstyle :compinstall filename '$HOME/.zshrc'
alias -g vi='/usr/local/Cellar/vim/8.1.0950/bin/vim'
alias -g vim='/usr/local/Cellar/vim/8.1.0950/bin/vim'
alias -g gvim='/usr/local/Cellar/vim/8.1.0950/bin/gvim'
# set gb path to GOPATH(move to project root as a premise)
alias -g gbpath='export GOPATH=$HOME/go:$(pwd):$(pwd)/vendor'
# ghq look via fzf
# git action toward branch via fzf
alias -g co='branch|fzf|xargs git checkout'
alias -g ghql='cd $(ghq list --p|fzf) && basename `pwd` | xargs tmux rename-window'
autoload -Uz compinit
compinit
# End of lines added by compinstall

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Set Spaceship ZSH as a prompt
autoload -U promptinit; promptinit
prompt spaceship
