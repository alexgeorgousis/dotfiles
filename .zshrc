# Path to your oh-my-zsh installation.
export ZSH="/Users/AGI53/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="robbyrussell"

# Automatically update oh-my-zsh without prompting
DISABLE_UPDATE_PROMPT="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
	git
	zsh-autosuggestions
	zsh-syntax-highlighting
	zsh-poetry
	asdf
        zsh-vi-mode
)

# zsh-vi-mode config
ZVM_VI_INSERT_ESCAPE_BINDKEY=jk

source $ZSH/oh-my-zsh.sh

export PYTHONDONTWRITEBYTECODE=1

#######
# Nix #
#######
# Required by home-manager
export NIX_PATH=$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels${NIX_PATH:+:$NIX_PATH}
# >If you do not plan on having Home Manager manage your shell configuration then you must source the following (source: https://nix-community.github.io/home-manager/index.html#sec-install-standalone)
source $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh

###########
# Aliases #
###########
alias kb='kubectl'
alias kbb='kubebuilder'
alias ncr='cd /Users/AGI53/repos/glados/disco-ml-nbcu-ncr'
alias dep='cd /Users/AGI53/repos/glados/disco-mlops-deployments'
alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
alias c='config'
alias cgst='config status'
alias cga='config add'
alias cgc='config commit'
alias cgam='config commit -a -m'
alias cgp='config push'
alias cgd='config diff'

# Enable auto-completion for kubectl and kubebuilder
source <(kubectl completion zsh)
source <(kubebuilder completion zsh)

#########
# Paths #
#########
export GOOGLE_APPLICATION_CREDENTIALS=/Users/AGI53/.config/gcloud/application_default_credentials.json
export JAVA_HOME=`/usr/libexec/java_home -v 1.8`
export GOPATH="$(go env GOPATH)"
export PATH=$HOME/bin:/usr/local/bin:$PATH
export PATH=$HOME/.local/bin:$PATH
export PATH="$(asdf where poetry):$PATH"
export PATH="$(go env GOPATH)/bin:$PATH"
export PATH="$HOME/cli/sbt/bin:$PATH"
export PATH="$HOME/cli/scala/bin:$PATH"
export PATH="/usr/local/opt/ruby/bin:$PATH"  # ruby installed with brew (added here to replace the default ruby version installed in macos)
export PATH="/usr/local/lib/ruby/gems/3.1.0/bin:$PATH"  # location of binaries installed by gem
export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"
export PATH="$HOME/.asdf/bin:$PATH"
# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/AGI53/google-cloud-sdk/path.zsh.inc' ]; then . '/Users/AGI53/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/AGI53/google-cloud-sdk/completion.zsh.inc' ]; then . '/Users/AGI53/google-cloud-sdk/completion.zsh.inc'; fi

[ -f "/Users/AGI53/.ghcup/env" ] && source "/Users/AGI53/.ghcup/env" # ghcup-env

# Enable FZF (fuzzy search)
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

