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
leo () { BACKEND=https://$1.leovegas.com APP=$2 npm run start }
api () {  curl http://localhost:8000/$1 | python -m json.tool }
work () { (cd apps/$1 && grunt work) }
cordova-build-local () { TARGET=local cordova build $1 }

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"
