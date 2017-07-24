# Plugins
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh

# This breaks bg/fg job management :(
#zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug 'mafredri/zsh-async', from:github
zplug 'sindresorhus/pure', use:pure.zsh, from:github, as:theme
zplug 'zsh-users/zsh-autosuggestions', from:github
zplug "plugins/git", from:oh-my-zsh
zplug 'zsh-users/zsh-syntax-highlighting', defer:2

zplug load

# History File
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt histignoredups   # Don't save lines if they're a duplicate of the previous line
setopt histreduceblanks # Remove superfluous blanks from each command

# Aliases
alias g=git
alias ll="ls -al"
alias copy-branch="git rev-parse --abbrev-ref HEAD | pbcopy"
alias lck="/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend"
alias vim=nvim
alias vi=nvim
alias o=open
alias tr=trash
alias ga=gfadd
alias fuck="rm -rf ./node_modules && yarn && rm yarn.lock"
alias fuck-up="g up orgin master && rm -rf ./node_modules && npm install"

# Other
export PATH="$HOME/scripts:$PATH"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8

# 256 colors tmux
export TERM=xterm-256color

# Custom VI mode in terminal
bindkey -v

bindkey '^P' up-history
bindkey '^N' down-history
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word
bindkey '^r' history-incremental-search-backward

export KEYTIMEOUT=1

# Platform specific commands
# Golang
export GOPATH=$HOME/golang
export GOROOT=/usr/local/opt/go/libexec
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

source ~/.bin/tmuxinator.zsh
# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='vim'
  export VISUAL='vim'
else
  export EDITOR='nvim'
  export VISUAL='nvim'
fi
# Leovegas shortcut commands
i18n () { (cd apps/mobile && grunt i18n) && (cd apps/desktop && grunt i18n) }
leo () { BACKEND=https://$1.leovegas.com APP=$2 npm run start }
api () {  curl http://localhost:8000/$1 | python -m json.tool }
work () { (cd apps/$1 && grunt work) }
cordova-build-local () { TARGET=local cordova build $1 }
brew-cask-upgrade() {
  if [ "$1" != '--quick' ]; then
    echo "Removing brew cache"
    rm -rf "$(brew --cache)"
    echo "Running brew update"
    brew update
  fi
  for c in $(brew cask list); do
    echo -e "\n\nInstalled versions of $c: "
    ls /opt/homebrew-cask/Caskroom/$c
    echo "Cask info for $c"
    brew cask info $c
    select ynx in "Yes" "No" "Exit"; do
      case $ynx in
        "Yes") echo "Uninstalling $c"; brew cask uninstall --force "$c"; echo "Re-installing $c"; brew cask install "$c"; break;;
        "No") echo "Skipping $c"; break;;
        "Exit") echo "Exiting brew-cask-upgrade"; return;;
      esac
    done
  done
}

fuck-e2e () {
  GIT_BRANCH=`git rev-parse --abbrev-ref HEAD`
  BRANCH=`basename $GIT_BRANCH`
  GIT_TAG_PREPUSH="prepush-$BRANCH"

  git fetch --tags && git tag -d ${GIT_TAG_PREPUSH} && git push origin :refs/tags/${GIT_TAG_PREPUSH} --no-verify
  git tag ${GIT_TAG_PREPUSH} -m "auto tag from successful pre-push run"
  git push origin ${GIT_TAG_PREPUSH} --no-verify || printf "\033[31mFailed to push git tag ${GIT_TAG_PREPUSH}\033[0m\n";
}

# FZF git add
# fuzzy multi-select modified file
#
gfmod() {
  git ls-files -m --others --exclude-standard | fzf -m
}

# stage files multi-selected modified files
gfadd() {
  git add $(gfmod)
}

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
