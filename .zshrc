# The following lines were added by compinstall
zstyle :compinstall filename '/Users/yy_yank/.zshrc'
alias -g vi='/usr/local/bin/vim'
alias -g vim='/usr/local/bin/vim'
alias -g gvim='/usr/local/bin/gvim'
# gb env -> GOPATH
alias -g gbpath=' gb env |grep SRC | sed -e \''s/src//g\'' | sed -e \''s/GB_SRC_PATH=//g\''  '

# ghq look via peco
alias -g pghql='cd $(ghq list --p|peco) |pwd'
# git action toward branch via peco
alias -g pbg='git branch|peco|xargs git'

autoload -Uz compinit
compinit
# End of lines added by compinstall
