sudo pacman -S --noconfirm --needed \
	git \
	base-devel \
	less \
	tldr \
	wl-clipboard \
	alacritty

yay -S --noconfirm --needed \
       	google-chrome \
	xremap-x11-bin

###############################
# Change capslock to esc/ctrl #
###############################

# These commands are needed so that xremap can run without sudo so that it can be run from hyprland's exec-once. Source: https://github.com/xremap/xremap#arch-linux-1
# They need a reboot to take effect. When I first tried this it didn't work and I kept trying to troubleshoot and eventually it magically worked (though I don't think I did anything to make that happen).
# One thing that ChatGPT said is that in order for the rule to take effect you need to be in a proper logind session which means you need to login via your login manager and not a TTY. No idea if that's correct though.

# Add alex to the input group
sudo gpasswd -a alex input

# Add a rule to give the input group read and write access to uinput
# You can confirm this has taken effect by running `ls -l /dev/uinput` - you should see `crw-rw root input`.
echo 'KERNEL=="uinput", GROUP="input", TAG+="uaccess"' | sudo tee /etc/udev/rules.d/99-input.rules

####################
# Misc Setup Stuff #
####################
