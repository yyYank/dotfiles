# show diff with diff-so-fancy
ccd() {
  clear
  echo "$(date '+%H:%M:%S') diff"
  echo "---"

  if git diff --name-only HEAD~ >/dev/null 2>&1; then
    git diff --name-only HEAD~ | while read file; do
      echo -e "\n$file"
      git diff HEAD~ -- "$file" | diff-so-fancy | less -R
    done
  else
    echo "no changes"
  fi
  echo -e "\n[ q: quit ]"
}

# aliases for mobile operation
mbal() {
  alias gp='echo "git push" && git push'
  alias gpl='echo "git pull" && git pull'
  alias gagc='echo "git add . && git commit ." && git add . && git commit .'
  alias tl='echo "tmux ls" && tmux ls'
  alias ta='echo "tmux attach -t" && tmux attach -t'
  alias tn='echo "tmux next-window" && tmux next-window'
  alias tns='echo "tmux new-session -s" && tmux new-session -s'
  alias tk='echo "tmux kill-session -t" && tmux kill-session -t'
  alias trw='echo "tmux rename-window" && tmux rename-window'
  alias bruc='echo "brew upgrade claude-code" && brew upgrade claude-code'

  echo "--- mbal aliases ---"
  alias gp gpl gagc tl ta tn tns tk trw bruc
}
