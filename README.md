# dotfiles

# Setup Guide

1. (Optional) Install Chrome and sign in to Google to make your life easier (e.g. bookmarks).
2. Install `git` and setup your GItHub SSH key.
1. Install Nix by running `sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon` ([source](https://nixos.org/download/#download-nix)).
1. Install `home-manager` by running the following ([source](https://nix-community.github.io/home-manager/index.xhtml#sec-install-standalone)):
    ```bash
    nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
    nix-channel --update
    nix-shell '<home-manager>' -A install

    # Remove the auto-generated default home.nix file. It will be replaced by the one in this repo later in the setup.
    rm ~/.config/home-manager/home.nix
    ``` 
1. Setup this dotfiles repo by running the following ([source](https://www.atlassian.com/git/tutorials/dotfiles)):
    ```bash
    alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
    echo ".cfg" >> .gitignore
    git clone --bare git@github.com:alexgeorgousis/dotfiles.git $HOME/.cfg
    alias config='/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
    rm ~/.gitignore  # remove .gitignore so that it can be overridden by the one in the dotfiles repo
    config checkout
    config config --local status.showUntrackedFiles no
    ``` 
    - Note: You might encounter this problem while running the above commands: `WARNING: UNPROTECTED PRIVATE KEY FILE!`. You need to run `chmod 600 ~/.ssh/<private_key>` to restrict the permissions on your private keys.
1. Run `home-manager switch` to set everything up.
2. Set `zsh` as your default shell by running the following:
    ```bash
    echo $HOME/.nix-profile/bin/zsh | sudo tee -a /etc/shells
    chsh -s $(which zsh)
    echo "Logout and log back in so the change can take effect."
    ```
3. Map CapsLock to Ctrl and Escape by running the following:
    ```bash
    sudo apt install build-essential -y  # this will install make, which is needed to build keyd from source.
    git clone https://github.com/rvaiya/keyd.git
    cd keyd
    make
    sudo make install
    cd
    sudo systemctl enable keyd --now
    rm -rf ~/keyd/ # cleanup: delete the repo
    ``` 


# Fonts
## How to set up Nerd Fonts
[Nerd Fonts](https://www.nerdfonts.com/font-downloads) are fonts that have been extended (patched) with icons that can be displayed inside terminal emulators.

### Tutorial
Source: https://www.youtube.com/watch?v=mQdB_kHyZn8

The steps are the following:
1. Download a font (collection of `.ttf` files) from the [Nerd Fonts website](https://www.nerdfonts.com/font-downloads)
2. Move all `.ttf` files to `~/.local/share/fonts` (create the `fonts` directory manually if it doesn't already exist)
3. Configure your terminal emulator to use the font - For Alacritty, edit the `alacritty.yml` file to set the `font.normal.family` property to the font you want, e.g.:
  ```
  font:
    normal:
      family: "Hack Nerd Font"
  ```
  
### Notes
- While there are nixpkgs for Nerd Fonts, I haven't figured out an easy way to install them via home manager and make them work. But since fonts are just files, I can install them once manually and then add them to this repo, so it's not a big deal.

- If you've setup your dotfiles from this repo, you should already have the [Hack Nerd Font](https://www.programmingfonts.org/#hack) set up with Alacritty.

# Troubleshooting
