#########################
# OhMyZsh Configuration #
#########################

# Path to your Oh My Zsh installation.
export ZSH="$ZDOTDIR/ohmyzsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time Oh My Zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes
ZSH_THEME="gozilla"

# Enable command correction suggestions.
# This is really nice: if you mistype part of a command it'll say "did you mean..." and you can press 'y' to accept the fix.
ENABLE_CORRECTION="true"

# Disable marking untracked files under VCS as dirty. This makes repository status check for large repositories much, much faster.
DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# NOTE: This should be set before sourcing oh-my-zsh.sh
plugins=(
	git
	zsh-vi-mode
	kubectl
)

source $ZSH/oh-my-zsh.sh

######################
# User configuration #
######################

# Enable auto suggestions and syntax highlighting
# Assumes those packages have been installed via pacman
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# <ENV VARS> #

export EDITOR='nvim'
export PATH=~/.asdf/shims/:$PATH

# </ENV VARS> #


# <KEYBINDS> #

source $ZDOTDIR/key-bindings.zsh

# </KEYBINDS> #


# <ALIASES> #

source $ZDOTDIR/aliases.zsh

# </ALIASES> #


# MISC #

# Customise zsh prompt
function kubectl_prompt() {
	local color="green"
	if [[ "$KUBECONTEXT" == *"prod"* ]]; then
		color="red"
	fi
	echo "%{$fg[$color]%}[$KUBECONTEXT/$KUBENAMESPACE]%{$reset_color%} %{$fg[yellow]%} "
}
PROMPT="%{$fg_bold[green]%}➜%{$reset_color%} "
PROMPT+="%{$fg_bold[magenta]%}[$(git --git-dir=$HOME/.cfg --work-tree=$HOME rev-parse --abbrev-ref HEAD)] "
PROMPT+="%{$fg[cyan]%}%c%{$reset_color%} "
PROMPT+='$(git_prompt_info) '
if [[ -n $KUBECONTEXT ]]; then
	PROMPT+="$(kubectl_prompt) "
fi

# Enable custom zsh functions
source $ZDOTDIR/functions.zsh

# Set up fzf
source /usr/share/fzf/completion.zsh
export FZF_CTRL_R_OPTS="--height 10%"
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :500 {}'"
