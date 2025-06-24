#!/bin/bash

set -e

####################
# Install packages #
####################

pacman_packages=(
	"git"
	"base"-devel
	"less"
	"tldr"
	"wl"-clipboard
	"alacritty"
	"zellij"
	"ttf"-hack-nerd
	"zsh"
	"zsh"-autosuggestions
	"zsh"-syntax-highlighting
	"neovim"
	"eza"
	"bat"
	"fd"
	"duf"
	"htop"
	"ripgrep"
	"procs"
	"fastfetch"
	"fzf"
	"kubectl"
	"waybar"
	"qemu-base go docker" # colima dependencies
	"bluez bluez-utils bluez-deprecated-tools blueman" # source: https://wiki.archlinux.org/title/Bluetooth#Installation
)

aur_packages=(
	"google-chrome"
	"xremap-x11-bin"
	"lima-bin" # colima dependency
)

sudo pacman -Syu # update and upgrade to make sure pacman has the latest packages
sudo pacman -S --noconfirm --needed ${pacman_packages[@]}
yay -S --noconfirm --needed ${aur_packages[@]}

# Install colima - source: https://github.com/abiosoft/colima/blob/main/docs/INSTALL.md#binary
# NOTE: There is an AUR package for colima, colima-bin, but it fails with a weird validation check error, so I chose the manual installation method instead.
if ! command -v colima >/dev/null 2>&1; then
	curl -LO https://github.com/abiosoft/colima/releases/latest/download/colima-$(uname)-$(uname -m)
	sudo install colima-$(uname)-$(uname -m) /usr/local/bin/colima
fi

###############################
# Change capslock to esc/ctrl #
###############################

# These commands are needed so that xremap can run without sudo so that it can be run from hyprland's exec-once. Source: https://github.com/xremap/xremap#arch-linux-1
# They need a reboot to take effect. When I first tried this it didn't work and I kept trying to troubleshoot and eventually it magically worked (though I don't think I did anything to make that happen).
# One thing that ChatGPT said is that in order for the rule to take effect you need to be in a proper logind session which means you need to login via your login manager and not a TTY. No idea if that's correct though.

# Add user to the input group if he's not there already.
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

#############
# Zsh setup #
#############

# Set zsh as default shell
if [ -z $ZDOTDIR ]; then
	echo "export ZDOTDIR=$HOME/.config/zsh" | sudo tee /etc/zsh/zshenv
fi

if [ $SHELL != $(which zsh) ]; then
	chsh -s $(which zsh)
fi

# Install ohmyzsh if it's not already installed
if [ ! -d "${ZSH:-$HOME/.oh-my-zsh}" ]; then
	sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

# Install oh-my-zsh custom plugins
if [ ! -d "$HOME/.config/zsh/ohmyzsh/custom/plugins/zsh-vi-mode" ]; then
	git clone https://github.com/jeffreytse/zsh-vi-mode $HOME/.config/zsh/ohmyzsh/custom/plugins/zsh-vi-mode
fi

####################
# Misc Setup Stuff #
####################

# Get bluetooth working - source: https://wiki.archlinux.org/title/Bluetooth#Installation
if ! systemctl is-active --quiet bluetooth; then
	sudo systemctl enable bluetooth
	sudo systemctl start bluetooth
fi
