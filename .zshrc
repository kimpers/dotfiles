# Plugins
export ZPLUG_HOME=/usr/local/opt/zplug
source $ZPLUG_HOME/init.zsh
fpath+=("/usr/local/share/zsh/site-functions")

# This breaks bg/fg job management :(
#zplug 'zplug/zplug', hook-build:'zplug --self-manage'
zplug 'mafredri/zsh-async', from:github
zplug 'sindresorhus/pure', use:pure.zsh, from:github, as:theme
zplug 'zsh-users/zsh-autosuggestions', from:github
zplug "plugins/git", from:oh-my-zsh
zplug 'zsh-users/zsh-syntax-highlighting', defer:2
zplug "paulirish/git-open", as:plugin

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
alias vis="nvim -u NONE"
alias o=open
alias ga=gfadd
alias ip="curl icanhazip.com"
alias dc=docker-compose
alias uuid="npx uuid v1 | pbcopy && pbpaste"
alias brewski='brew update && brew upgrade && brew cleanup; brew doctor'
alias yarn-project-linked-packages="find . -type l | grep -v .bin | sed 's/^\.\/node_modules\///'"
alias yarn-global-linked-packages='find ~/.config/yarn/link  -maxdepth 2 -type l | xargs realpath -s --relative-to ~/.config/yarn/link'

# Other
USER_BASE_PATH=$(python -m site --user-base)
export PATH="$HOME/scripts:/usr/local/bin:$USER_BASE_PATH/bin:$PATH"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export GPG_TTY=`tty`

# Android Dev
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools

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

db() {
  item=$(op get item $1)
  username=$(echo $item | jq -c '.details.sections[0].fields[] | select(.n=="username")'.v | sed 's/"//g')
  hostname=$(echo $item | jq -c '.details.sections[0].fields[] | select(.n=="hostname")'.v  | sed 's/"//g')
  port=$(echo $item | jq -c '.details.sections[0].fields[] | select(.n=="port")'.v  | sed 's/"//g')


  echo $item | jq -c '.details.sections[0].fields[] | select(.n=="password")'.v | sed 's/"//g' | pbcopy
  pgcli --host $hostname --host $hostname -U $username --port $port
  echo "" | pbcopy
}

# Codi
# Usage: codi [filetype] [filename]
codi() {
  local syntax="${1:-javascript}"
  shift
  vim -c \
    "let g:startify_disable_at_vimenter = 1 |\
    set bt=nofile ls=0 noru nonu nornu |\
    hi ColorColumn ctermbg=NONE |\
    hi VertSplit ctermbg=NONE |\
    hi NonText ctermfg=0 |\
    Codi $syntax" "$@"
}


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[ -f ~/.dotfiles/.zsh_private ] && source ~/.dotfiles/.zsh_private

# Kubernetes auto-complete
if [ $commands[kubectl] ]; then
  source <(kubectl completion zsh)
fi

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
# Load pyenv
eval "$(pyenv init -)"

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/kim/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/kim/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/kim/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/kim/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

  if type brew &>/dev/null; then
    FPATH=$(brew --prefix)/share/zsh-completions:$FPATH

    autoload -Uz compinit
    compinit
  fi


export YVM_DIR=/usr/local/opt/yvm
[ -r $YVM_DIR/yvm.sh ] && . $YVM_DIR/yvm.sh

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true
