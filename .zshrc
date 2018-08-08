#ANSI Color Constants
RED='\033[0;31m'
NC='\033[0m' # No Color
BLUE='\033[1;34m'
GREEN='\033[0;32m'
# The following lines were added by compinstall
# git untracked count
function git_prompt_untracked_count {
  if ( `git rev-parse > /dev/null 2>&1` ) ; then 
    if [[ "$HOST" == "linode" ]] ; then
      local COUNT=$(git ls-files -o --exclude-standard 2>/dev/null | wc -l| tr -d ' ')
    else
      local COUNT=$(git ls-files --other --exclude-standard 2>/dev/null | wc -l | awk '{print $1}')
    fi
  fi
  if [ "$COUNT" -gt 0 ]; then
    echo " ${RED}untracked:($COUNT) ${NC}"
  fi
}

setopt prompt_subst
autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null
function rprompt-git-current-branch {
  local name action

  if [[ "$PWD" =~ '/\.git(/.*)?$' ]]; then
    echo "zsh: "
    return
  fi

  name=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
  if [[ -z $name ]]; then
    echo "zsh: "
    return
  fi

  gitdir=`git rev-parse --git-dir 2> /dev/null`

  # %{...%} surrounds escape string
  echo "${BLUE}zsh:${GREEN}%{[%}$name%{]% ${NC}`git_prompt_untracked_count`%{$reset_color%} "
}

PROMPT='`rprompt-git-current-branch`'
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
alias -g co='branch|fzf|xargs git checkout'
alias -g look='list|fzf|xargs ghq look'

autoload -Uz compinit
compinit
# End of lines added by compinstall
