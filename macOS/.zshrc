if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi
source $HOMEBREW_PREFIX/share/zsh-history-substring-search/zsh-history-substring-search.zsh
source $HOMEBREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh
source $HOMEBREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source $HOMEBREW_PREFIX/opt/spaceship/spaceship.zsh

HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt SHARE_HISTORY
setopt EXTENDED_HISTORY

export GOPATH=$HOME/go
export PGDATA=/usr/local/var/postgres
export LANG=ja_JP.UTF-8
fpath=(~/.zfunc $HOMEBREW_PREFIX/share/zsh-completions $fpath)
autoload -Uz compinit
compinit

export JAVA_HOME=/Library/Java/JavaVirtualMachines/zulu-11.jdk/Contents/Home
export PATH=$GOPATH:$GOPATH/bin:$JAVA_HOME/bin:$PATH

alias -g gbpath='export GOPATH=$(pwd):$(pwd)/vendor:$HOME/go:'
alias -g co='branch|fzf|xargs git checkout'
alias -g ghql='cd $(ghq list --p|fzf) && basename `pwd` | xargs tmux rename-window'
alias -g gwqa='gwq add $(git branch|fzf)'

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# fzfに「.gitとかの中身は無視して探してこい」と命令する設定
export FZF_DEFAULT_COMMAND='find . -name .git -prune -o -name node_modules -prune -o -type f -print'

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="/Users/yy_yank/.sdkman"
[[ -s "/Users/yy_yank/.sdkman/bin/sdkman-init.sh" ]] && source "/Users/yy_yank/.sdkman/bin/sdkman-init.sh"

eval "$(mise activate zsh)"

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '^xe' edit-command-line

[ -f ~/.zsh/functions.zsh ] && source ~/.zsh/functions.zsh

# set tmux pane title to current directory name
if [[ -n "$TMUX" ]]; then
  autoload -Uz add-zsh-hook
  add-zsh-hook precmd _set_pane_title
  _set_pane_title() { printf '\033]2;%s\033\\' "${PWD##*/}" }
fi

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/yy_yank/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/yy_yank/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/yy_yank/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/yy_yank/google-cloud-sdk/completion.zsh.inc'; fi

### MANAGED BY RANCHER DESKTOP START (DO NOT EDIT)
export PATH="/Users/yy_yank/.rd/bin:$PATH"
### MANAGED BY RANCHER DESKTOP END (DO NOT EDIT)
