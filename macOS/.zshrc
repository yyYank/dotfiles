source $HOMEBREW_PREFIX/share/zsh-history-substring-search/zsh-history-substring-search.zsh
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOMEBREW_PREFIX/opt/spaceship/spaceship.zsh
# source /usr/local/share/zsh-completions/zsh-completions.plugin.zsh
# source ~/.zsh/zsh-autosuggestions/zsh-autosuggestions.zsh
# source ~/.zsh/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# source ~/.zsh/zsh-completions/zsh-completions.plugin.zsh
export GOPATH=$HOME/go
export PGDATA=/usr/local/var/postgres
export LANG=ja_JP.UTF-8
fpath=($HOMEBREW_PREFIX/share/zsh-completions $fpath)
autoload -U compinit
compinit -u

#ANSI Color Constants
RED='\033[0;31m'
NC='\033[0m' # No Color
BLUE='\033[1;34m'
GREEN='\033[0;32m'
zstyle :compinstall filename '$HOME/.zshrc'
# alias -g vi='/usr/local/bin/vim'
# alias -g vim='/usr/local/bin/vim'
# alias -g gvim='/usr/local/bin/gvim'
# alias -g java='/Library/Java/JavaVirtualMachines/jdk1.8.0_181.jdk/Contents/Home/bin/java'

export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-11.jdk/Contents/Home
#/Library/Java/JavaVirtualMachines/jdk1.8.0_181.jdk/Contents/Home
export PATH=$GOPATH:$GOPATH/bin:$JAVA_HOME/bin:$PATH
# set gb path to GOPATH(move to project root as a premise)
alias -g gbpath='export GOPATH=$(pwd):$(pwd)/vendor:$HOME/go:'
# ghq look via fzf
# git action toward branch via fzf
alias -g co='branch|fzf|xargs git checkout'
alias -g ghql='cd $(ghq list --p|fzf) && basename `pwd` | xargs tmux rename-window'
autoload -Uz compinit
compinit
#export PATH="/usr/local/opt/python@3.8/bin:$PATH"

# End of lines added by compinstall

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
  # Set Spaceship ZSH as a prompt
  autoload -U promptinit; promptinit
  prompt spaceship

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/yy_yank/.sdkman"
[[ -s "/Users/yy_yank/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/yy_yank/.sdkman/bin/sdkman-init.sh"

eval "$(mise activate zsh)"

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/yy_yank/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
export PATH="$HOME/.rd/bin:$PATH"

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line
