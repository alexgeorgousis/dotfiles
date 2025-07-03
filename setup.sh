#!/bin/bash

set -e

####################
# Install packages #
####################

apt_packages=(
	"neovim"
	"eza" # prettier ls
	"bat" # prettier cat
	"fd" # prettier and better find
	"duf" # prettier alternative to df - displays disk usage
	"htop" # process viewer - alternative to top
	"ripgrep" # grep replacement
	"procs" # ps replacement
	"wget"
	"curl"
	"watch"
	"jq"
	"yq"
	"asdf-vm"
	"argo"
	"argocd"
	"gopls"  # go language server
	"difftastic"

	# Docker
	"docker"

	# Kubernetes
	"kubectl"
	"k9s"
	"kubernetes-helm"
	"helmsman"
	"kubebuilder"

	# used to manage rust - includes rust compiler, cargo pkg manager, and rust-analyzer LSP server
	# to use rust-analyzer you'll need to install it with rustup component add rust-analyzer
	# to check that you have it, run `rust-analyzer` in terminal (don't worry about the actual output, just make sure
	# it doesn't output an error)
	"rustup"
	"bacon" # runs rust checks, build, tests etc automatically

	"protobuf"
	"coreutils"
	# fluxcd # flux CLI tool - the most recent version has hardcoded apiVersion of helmrelease kind, which is lower than what I have in the clusters I work in, so I had to download a lower version with homebrew using: brew install fluxcd/tap/flux@2.1
	"vault"
	"git-crypt"
	"twine"
	"awscli2"
	"fastfetch"
	"gh"
	"terraform"
	"zellij"
	"tldr"
	"nerd-fonts.jetbrains-mono"

	# Sway
	"sway"
	"swayidle"
	# Disabled because I couldn't make the authentication worked.
	# See https://github.com/alexgeorgousis/dotfiles/issues/26
	# Instead I'm installing vanilla swaylock using apt
	# swaylock-effects
	"fuzzel"
	"wl-clipboard" # used to give neovim access to clipboard (so I can paste stuff into neovim)
	"waybar" # status bar (where the workspace numbers are)
	"bluez" # bluetooth core tool
	"blueman" # bluetooth GUI
	"grim" # Takes screenshots
	"slurp" # Select area (used for screenshots)
	"pwvucontrol" # pipewire audio control (used in waybar)

	# xdg-desktop-portal backend for wlroots (which is used by Sway) - used for screencasting (e.g. screensharing) and screenshots
	# https://github.com/emersion/xdg-desktop-portal-wlr
	"xdg-desktop-portal-wlr"

	# Used by pipewire which is used to authenticate screensharing
	# Arch Wiki: https://wiki.archlinux.org/title/WirePlumber
	"wireplumber"

	# Apps
	"google-chrome"
	"spotify"
	"telegram-desktop"

	"ruby-full"
)

sudo apt update && sudo apt upgrade -y
sudo apt install -y ${apt_packages[@]}

###############################
# Change capslock to esc/ctrl #
###############################

# These commands are needed so that xremap can run without sudo so that it can be run from hyprland's exec-once. Source: https://github.com/xremap/xremap#arch-linux-1
# They need a reboot to take effect. When I first tried this it didn't work and I kept trying to troubleshoot and eventually it magically worked (though I don't think I did anything to make that happen).
# One thing that ChatGPT said is that in order for the rule to take effect you need to be in a proper logind session which means you need to login via your login manager and not a TTY. No idea if that's correct though.

# Add user to the input group if they're not there already.
# To confirm this has worked run `groups user` and look for `input` in the list.
if ! id -nG $USER | grep -qw input; then
	sudo gpasswd -a $USER input
fi

# Make uinput module get loaded automatically - you can confirm it's done by running `lsmod | grep uinput` and checking it's listed.
# You need to reboot for this to take effect.
if ! cat /etc/modules-load.d/uinput.conf | grep -qw uinput; then
	echo uinput | sudo tee /etc/modules-load.d/uinput.conf
fi

# Add a rule to give the input group read and write access to uinput
# You can confirm this has taken effect by running `ls -l /dev/uinput` - you should see `crw-rw root input`.
if [ ! -e /etc/udev/rules.d/99-input.rules ]; then
	echo 'KERNEL=="uinput", GROUP="input", TAG+="uaccess"' | sudo tee /etc/udev/rules.d/99-input.rules
fi

##############
# Fish setup #
##############

# Set fish as default shell
if [ $SHELL != $(which fish) ]; then
	chsh -s $(which fish)
fi

# Install Fisher if it's not already installed
if ! command -v fish -c "fisher" &>/dev/null; then
	fish -c "curl -sL https://raw.githubusercontent.com/jorgebucaran/fisher/main/functions/fisher.fish | source && fisher install jorgebucaran/fisher"
fi

# Install plugins
plugins=(
	"PatrickF1/fzf.fish"
	"vitallium/tokyonight-fish"
	"jorgebucaran/autopair.fish"
)
for p in ${plugins[@]}; do
	if ! fish -c "fisher list" | grep -i $p &>/dev/null; then
		fish -c "fisher install $p"
	fi
done

# Set theme
# NOTE: I've commented this out because I can't figure out how to check if the theme is already set so fish always asks me "do you want to override the current theme [y/N]" and waits for input.
# It's an easy command to write out manually anyway.
# fish -c "fish_config theme save 'TokyoNight Night'"


####################
# Misc Setup Stuff #
####################

# Get bluetooth working - source: https://wiki.archlinux.org/title/Bluetooth#Installation
if ! systemctl is-active --quiet bluetooth; then
	sudo systemctl enable bluetooth
	sudo systemctl start bluetooth
fi

# Run Docker daemon
if ! systemctl is-active --quiet docker; then
	sudo systemctl enable --now docker
fi

# Add user to docker group if not already there (needed for permissions).
if ! id -nG $USER | grep -qw docker; then
	sudo gpasswd -a $USER docker
fi

# Set docker.sock group to docker if not set already
if [[ $(stat -c '%G' "/var/run/docker.sock") != "docker" ]]; then
	sudo chgrp docker /var/run/docker.sock
fi
