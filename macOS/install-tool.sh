# brew install済みの想定
if [ "$(which brew)" == "" ]; then
    echo "brew not found"
    exit 1
fi

# general
brew install git
# diff highlightを有効にする
sudo ln -s /usr/local/share/git-core/contrib/diff-highlight/diff-highlight /usr/local/bin/diff-highlight
brew install vim –with lua
brew install tmux
brew install fzf
brew install ripgrep
brew install tree
brew install ghq
brew tap caskroom/fonts
brew cask install font-hack-nerd-font
brew install eeattach-to-user-namespace
brew install toshimaru/nyan/nyan
brew install ctags
# Java
brew install gradle
# zsh
brew install zsh
brew install zsh-completions
brew install zsh-autosuggestions
brew install zsh-history-substring-search
brew install zsh-syntax-highlighting
brew install z
# or, manualy git clone
# git clone https://github.com/zsh-users/zsh-completions.git ~/.zsh/zsh-completions
# git clone https://github.com/zsh-users/zsh-autosuggestions ~/.zsh/zsh-autosuggestions
# git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.zsh/zsh-syntax-highlighting
# git clone https://github.com/rupa/z.git ~/.zsh/z
# db cli
brew install pgcli
brew install mycli
# language
brew install go
brew install python3
# js
brew install node
brew install npm
brew install yarn
# docker
brew install ctop
brew install jesseduffield/lazydocker/lazydocker
brew install lazydocker
brew tap skanehira/docui
brew install docui
# redis
brew install redis

# npm install
npm install gtop -g
npm install -g spaceship-prompt
sudo npm i -g typescript
