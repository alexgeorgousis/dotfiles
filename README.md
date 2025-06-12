# dotfiles

# Setup Guide

1. (Optional) Install Chrome and sign in to Google to make your life easier (e.g. bookmarks).
1. Install `git` and setup your GItHub SSH key.
    - `git` will eventually be managed by `home-manager` but you need it to clone this repo.
    - Make sure your SSH keys are called `default` and `default.pub` (explained [below](#github-ssh-keys)). 
1. Install Nix by running the following ([source](https://nixos.org/download/#download-nix)):
    ```bash
    sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
    ```
    - If you get `/dev/fd/63: 122: /tmp/nix-binary-tarball-unpack.lqZd6YG1Rm/unpack/nix-2.29.0-x86_64-linux/install: Permission denied` it's probably because your `/tmp/` directory has been mounted with the `noexec` option, which means nothing inside it can be executed. Run the following to temporarily change that (this will be reverted the next time you reboot):
        ```bash
        sudo mount -o remount,exec /tmp
        ```
    - To verify it's fixed, run the following:
        ```bash
        mount | grep /tmp
        ```
        - You should see `/tmp/` and no mention of `noexec` 
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
1. Run `home-manager switch` to set everything up.
1. Set `zsh` as your default shell by running the following:
    ```bash
    echo $HOME/.nix-profile/bin/zsh | sudo tee -a /etc/shells
    chsh -s $(which zsh)
    echo "Logout and log back in so the change can take effect."
    ```
1. Map CapsLock to Ctrl and Escape by running the following:
    ```bash
    sudo apt install build-essential -y  # this will install make, which is needed to build keyd from source.
    git clone https://github.com/rvaiya/keyd.git
    cd keyd
    make && sudo make install
    cd
    sudo systemctl enable keyd --now
    rm -rf ~/keyd/ # cleanup: delete the repo
    ```
    - If the remapping hasn't worked, it's probably because the `keyd` README says the config needs to be in `/etc/keyd/default.conf` and not in `~/.config/keyd/default.conf`. So run the following to copy it there:
        ```bash
        sudo cp ~/.config/keyd/default.conf /etc/keyd/default.conf
        ```
        - It has worked by leaving it in the user config so I'm not sure why it doesn't always work. Also committing `/etc/keyd/default.conf` isn't an option because it's outside the scope of the repo.
1. Install Alacritty
    - Unfortunately the Nix package seeems to have problems. It throws `Error: Error { raw_code: None, raw_os_message: None, kind: NotSupported("provided display handle is not supported") }`.
    - If you're on Ubuntu 24.04 run:
        ```bash
        sudo apt install alacritty -y
        ```
    - If you're on Ubuntu 22.04 you need to add a repository first before installing alacritty. Run:
        ```bash
        sudo add-apt-repository ppa:aslatter/ppa -y && sudo apt install alacritty -y
        ```
1. Install Sway
    - Again, unfortunately, the Nix package for sway (or swayfx) throws an error on startup (i.e. when running `sway`):
        ```
        00:00:00.007 [wlr] [render/egl.c:208] EGL_EXT_platform_base not supported
        00:00:00.007 [wlr] [render/egl.c:523] Failed to create EGL context
        00:00:00.007 [wlr] [render/fx_renderer/fx_renderer.c:283] Could not initialize EGL
        00:00:00.007 [sway/server.c:236] Failed to create renderer
        ```
    ```bash
    sudo apt install sway -y
    ```
    - Also unfortunately, swayfx seems to require building from source and I don't really wanna bother with all that (and the potential issues that might come up) so I'm sticking with standard sway for now.
1. (Optional) Install `gcloud` (steps taken from [official installation guide](https://cloud.google.com/sdk/docs/install#deb) for Ubuntu/Debian):
    ```bash
    sudo apt update -y && sudo apt install -y apt-transport-https ca-certificates gnupg curl
    curl https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmor -o /usr/share/keyrings/cloud.google.gpg
    echo "deb [trusted=yes] https://packages.cloud.google.com/apt cloud-sdk main" | sudo tee -a /etc/apt/sources.list.d/google-cloud-sdk.list
    sudo apt update && sudo apt install -y google-cloud-cli
    sudo apt install -y google-cloud-cli-gke-gcloud-auth-plugin
    gcloud init
    ```
1. (Optional) Install `aws` CLI (steps taken from [official installation guide](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html#getting-started-install-instructions)):
    ```bash
    curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
    unzip awscliv2.zip
    sudo ./aws/install
    rm -rf aws/ awscliv2.zip
    aws --version # checking installation was successful
    ```
1. (Optional) Install `flux` CLI (available as a Nix package but the version has issues (see home.nix for details)):
    ```bash
    wget https://github.com/fluxcd/flux2/releases/download/v2.1.0/flux_2.1.0_linux_amd64.tar.gz
    mv flux_2.1.0_linux_amd64.tar.gz ~/bin/
    cd ~/bin
    tar -xzf flux_2.1.0_linux_amd64.tar.gz
    rm flux_2.1.0_linux_amd64.tar.gz
    ```

# GitHub SSH Keys

In `home-manager` you can see `git` is configured to use `~/.ssh/default` as the default key for auth and signing. This is to allow different machines to use different keys without changing the `home-manager` config. If you need to use different keys for different repos, then you'll have to generate those keys separately and configure those repos to use them manually (perhaps until I figure out a way to enable that feature).

# Disable laptop screen when lid is closed

By default, sway still detects laptop screens even if the laptop lid is closed. So you can switch to the workspace on the laptop screen or move the mouse off the main screen. This is annoying and I haven't found a good solution (I documented what ChatGPT recommended in a comment in the sway config).

The way to do it manually, thankfully, is quite simple:
```bash
# This assumes the name of the laptop display is eDP-1. You can check by running swaymsg -t get_outputs.
swaymsg output eDP-1 disable
```

# Troubleshooting

## Unable to login to Slack due to issues with Microsoft Intune Portal

What roughly happens is:
1. I open Slack
2. I click the green button to sign in.
3. It opens a browser and takes me to a Microsoft login page (typical SSO process).
4. It says my organisation requires this device to be registered with Intune Portal so I need to Get the App (which links to the Microsoft docs to set things up).
    - The problem at this point is that I've already got Intune Portal installed and have already completed the entire registration process.
    - All that needs to happen is I need to open the Intune Portal app and sign in.
5. I open Intune Portal and click Sign In.
6. Intune Portal opens a new window (which I assume is its attempt to open an embedded browser) which takes me through the normal Microsoft MFA login process.
7. I complete sign in and then it says "Get the app" (which is wrong).
8. I click on Get the App and the window goes blank.

The "solution" (which I haven't confirmed) is
1. Switch to a Gnome session (it all works there)
2. Open Intune Portal, sign in and wait until it does its compliance check
3. Sign in to sway and open Slack - it might just work at this point; if not:
4. Right clink to copy the slack sign in link and paste it into Edge - it might work at this pont.
5. If not, find the intune-portal PID running in gnome and kill it. Launch intune portal in sway. Now it might work.

## Waybar doesn't load

This happens because the xdg-desktop-portal service (or whatever it's called) fails to load. I haven't gotten to the bottom of this, but a workaround seems to be logging into a GNOME session (which presumably loads the service successfully) and then switching to a TTY to load sway.

Needs investigation to find the root cause and a more permanent solution.
