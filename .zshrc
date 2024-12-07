# Use always python3
alias python=python3
# Plugins
export ZPLUG_HOME=/opt/homebrew/opt/zplug
source $ZPLUG_HOME/init.zsh
fpath+=("/usr/local/share/zsh/site-functions")

# This breaks bg/fg job management :(
zplug 'zplug/zplug', hook-build:'zplug --self-manage', from:github
zplug mafredri/zsh-async, from:github
zplug sindresorhus/pure, use:pure.zsh, from:github, as:theme
zplug "plugins/git", from:oh-my-zsh
zplug 'zsh-users/zsh-syntax-highlighting', defer:2
zplug 'zsh-users/zsh-autosuggestions', from:github
zplug "paulirish/git-open", as:plugin

zplug load

# History File
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt histignoredups   # Don't save lines if they're a duplicate of the previous line
setopt histreduceblanks # Remove superfluous blanks from each command

ulimit -n 2048

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
alias flush-dns="sudo dscacheutil -flushcache;sudo killall -HUP mDNSResponder"
alias cargo-clean-all="find . -type d -depth 1 -exec sh -c 'cd {} && cargo clean' \;"

# Other
USER_BASE_PATH=$(python -m site --user-base)
export PATH="$HOME/scripts:/usr/local/bin:$USER_BASE_PATH/bin:$USER_BASE_PATH/scripts:$USER_BASE_PATH/.local/bin:$PATH"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LANGUAGE=en_US.UTF-8
export GPG_TTY=`tty`

# Android Dev
export ANDROID_HOME=$HOME/Library/Android/sdk
export PATH=$PATH:$ANDROID_HOME/tools
export PATH=$PATH:$ANDROID_HOME/tools/bin
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/emulator

# 256 colors tmux
export TERM=xterm-256color

export AWS_PROFILE=eng

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
export GOROOT="$(brew --prefix golang)/libexec"
export PATH=$PATH:$GOPATH/bin
export PATH=$PATH:$GOROOT/bin

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

mov2gif() {
  ffmpeg -i $1 -pix_fmt rgb8 -r 10 output.gif && gifsicle -O3 output.gif -o output.gif
}

bump-manifest() {
  jq ".version = \"$(jq -r '.version' package.json)\"" public/manifest.json | sponge public/manifest.json && yarn prettier -w public/manifest.json
}

op_select() {
  op item list --format=json | jq -r '.[].title' | fzf
}

op_get_pw() {
  op_select | xargs -I{} op item get --reveal --fields password --reveal {}
}

op_pgcli() {
  pgcli "$(op_get_pw)"
}

open_select() {
  rg -l "$1" | fzf | xargs nvim
}

open_match() {
  rg -l "$1" | xargs nvim
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

export YVM_DIR=/usr/local/opt/yvm
[ -r $YVM_DIR/yvm.sh ] && . $YVM_DIR/yvm.sh

# tabtab source for packages
# uninstall by removing these lines
[[ -f ~/.config/tabtab/zsh/__tabtab.zsh ]] && . ~/.config/tabtab/zsh/__tabtab.zsh || true

export PATH="$PATH:/Users/kim/.foundry/bin"
export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"
# Brew installed LLVM settings
export LDFLAGS="-L/opt/homebrew/opt/llvm/lib"
export CPPFLAGS="-I/opt/homebrew/opt/llvm/include"
export PATH="/opt/homebrew/opt/libpq/bin:$PATH"
export PATH="/Users/kim/Development/solana-blowfish/target/debug:$PATH"
# Phantom DEV ENV
export PHANTOM_BACKEND_S3_BUCKET=kim-phantom-backend-terraform-state

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/kim/Downloads/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/kim/Downloads/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/kim/Downloads/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/kim/Downloads/google-cloud-sdk/completion.zsh.inc'; fi

# pnpm
export PNPM_HOME="/Users/kim/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end

# bun completions
[ -s "/Users/kim/.bun/_bun" ] && source "/Users/kim/.bun/_bun"
. "$HOME/.cargo/env"

[[ -s "/Users/kim/.gvm/scripts/gvm" ]] && source "/Users/kim/.gvm/scripts/gvm"
export PATH="/opt/homebrew/opt/llvm/bin:$PATH"

ghcs() {
	FUNCNAME="$funcstack[1]"
	TARGET="shell"
	local GH_DEBUG="$GH_DEBUG"
	local GH_HOST="$GH_HOST"

	read -r -d '' __USAGE <<-EOF
	Wrapper around \`gh copilot suggest\` to suggest a command based on a natural language description of the desired output effort.
	Supports executing suggested commands if applicable.

	USAGE
	  $FUNCNAME [flags] <prompt>

	FLAGS
	  -d, --debug           Enable debugging
	  -h, --help            Display help usage
	      --hostname        The GitHub host to use for authentication
	  -t, --target target   Target for suggestion; must be shell, gh, git
	                        default: "$TARGET"

	EXAMPLES

	- Guided experience
	  $ $FUNCNAME

	- Git use cases
	  $ $FUNCNAME -t git "Undo the most recent local commits"
	  $ $FUNCNAME -t git "Clean up local branches"
	  $ $FUNCNAME -t git "Setup LFS for images"

	- Working with the GitHub CLI in the terminal
	  $ $FUNCNAME -t gh "Create pull request"
	  $ $FUNCNAME -t gh "List pull requests waiting for my review"
	  $ $FUNCNAME -t gh "Summarize work I have done in issues and pull requests for promotion"

	- General use cases
	  $ $FUNCNAME "Kill processes holding onto deleted files"
	  $ $FUNCNAME "Test whether there are SSL/TLS issues with github.com"
	  $ $FUNCNAME "Convert SVG to PNG and resize"
	  $ $FUNCNAME "Convert MOV to animated PNG"
	EOF

	local OPT OPTARG OPTIND
	while getopts "dht:-:" OPT; do
		if [ "$OPT" = "-" ]; then     # long option: reformulate OPT and OPTARG
			OPT="${OPTARG%%=*}"       # extract long option name
			OPTARG="${OPTARG#"$OPT"}" # extract long option argument (may be empty)
			OPTARG="${OPTARG#=}"      # if long option argument, remove assigning `=`
		fi

		case "$OPT" in
			debug | d)
				GH_DEBUG=api
				;;

			help | h)
				echo "$__USAGE"
				return 0
				;;

			hostname)
				GH_HOST="$OPTARG"
				;;

			target | t)
				TARGET="$OPTARG"
				;;
		esac
	done

	# shift so that $@, $1, etc. refer to the non-option arguments
	shift "$((OPTIND-1))"

	TMPFILE="$(mktemp -t gh-copilotXXXXXX)"
	trap 'rm -f "$TMPFILE"' EXIT
	if GH_DEBUG="$GH_DEBUG" GH_HOST="$GH_HOST" gh copilot suggest -t "$TARGET" "$@" --shell-out "$TMPFILE"; then
		if [ -s "$TMPFILE" ]; then
			FIXED_CMD="$(cat $TMPFILE)"
			print -s "$FIXED_CMD"
			echo
			eval "$FIXED_CMD"
		fi
	else
		return 1
	fi
}

ghce() {
	FUNCNAME="$funcstack[1]"
	local GH_DEBUG="$GH_DEBUG"
	local GH_HOST="$GH_HOST"

	read -r -d '' __USAGE <<-EOF
	Wrapper around \`gh copilot explain\` to explain a given input command in natural language.

	USAGE
	  $FUNCNAME [flags] <command>

	FLAGS
	  -d, --debug      Enable debugging
	  -h, --help       Display help usage
	      --hostname   The GitHub host to use for authentication

	EXAMPLES

	# View disk usage, sorted by size
	$ $FUNCNAME 'du -sh | sort -h'

	# View git repository history as text graphical representation
	$ $FUNCNAME 'git log --oneline --graph --decorate --all'

	# Remove binary objects larger than 50 megabytes from git history
	$ $FUNCNAME 'bfg --strip-blobs-bigger-than 50M'
	EOF

	local OPT OPTARG OPTIND
	while getopts "dh-:" OPT; do
		if [ "$OPT" = "-" ]; then     # long option: reformulate OPT and OPTARG
			OPT="${OPTARG%%=*}"       # extract long option name
			OPTARG="${OPTARG#"$OPT"}" # extract long option argument (may be empty)
			OPTARG="${OPTARG#=}"      # if long option argument, remove assigning `=`
		fi

		case "$OPT" in
			debug | d)
				GH_DEBUG=api
				;;

			help | h)
				echo "$__USAGE"
				return 0
				;;

			hostname)
				GH_HOST="$OPTARG"
				;;
		esac
	done

	# shift so that $@, $1, etc. refer to the non-option arguments
	shift "$((OPTIND-1))"

	GH_DEBUG="$GH_DEBUG" GH_HOST="$GH_HOST" gh copilot explain "$@"
}
export "GPG_TTY=/dev/ttys000"
