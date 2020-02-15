# general
pacman  --needed -S git
# diff highlightを有効にする
# sudo ln -s /usr/local/share/git-core/contrib/diff-highlight/diff-highlight /usr/local/bin/diff-highlight
# vimは自前でビルドしよう
# pacman --needed -S vim –with lua
pacman --needed -S tmux
# clipboard copy
pacman --needed -S xsel
pacman --needed -S fzf
pacman --needed -S ripgrep
pacman --needed -S tree
pacman --needed -S ghq
brew tap caskroom/fonts
brew cask install font-hack-nerd-font
pacman --needed -S eeattach-to-user-namespace
pacman --needed -S toshimaru/nyan/nyan
pacman --needed -S ctags
# Java
pacman --needed -S gradle
# zsh
pacman --needed -S zsh
pacman --needed -S zsh-completions
pacman --needed -S zsh-autosuggestions
pacman --needed -S zsh-history-substring-search
pacman --needed -S zsh-syntax-highlighting
pacman --needed -S z
# or, manualy git clone
# git clone https://github.com/zsh-users/zsh-completions.git ~/.zsh/zsh-completions
# git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
# git clone https://github.com/rupa/z.git ~/.zsh/z
# db cli
pacman --needed -S pgcli
pacman --needed -S mycli
# language
pacman ---needed S go
pacman ---needed S python3
# js
pacman ---needed S node
pacman ---needed S npm
pacman ---needed S yarn
# docker
pacman ---needed S ctop
pacman ---needed S jesseduffield/lazydocker/lazydocker
pacman ---needed S lazydocker
brew tap skanehira/docui
pacman ---needed S docui
# redis
pacman ---needed S redis

# npm install
npm install gtop -g
npm install -g spaceship-prompt
sudo npm i -g typescript
