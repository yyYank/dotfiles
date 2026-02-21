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
