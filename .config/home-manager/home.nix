{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    neovim
    alacritty
    silver-searcher # used by FZF (:Ag) and CtrlSF to search for text in files
    eza # prettier ls
    bat # prettier cat
    fd # prettier and better find
    duf # prettier alternative to df - displays disk usage
    htop # process viewer - alternative to top
    ripgrep # grep replacement
    procs # ps replacement
    wget
    curl
    watch
    jq
    # yq from nix has issues for some reason, so install it manually
    # yq
    asdf-vm
    argo
    gopls  # go language server

    # Docker
    docker
    docker-compose
    colima # docker runtime - open source replacement for Docker Desktop app

    # Kubernetes
    kubectl
    kubecolor
    k9s # config in ~/.config/k9s/config.yaml
    kubernetes-helm
    helmsman # used to run minikube tests for bibcd-genesys modules
    kubebuilder

    # used to manage rust - includes rust compiler, cargo pkg manager, and rust-analyzer LSP server
    # to use rust-analyzer you'll need to install it with rustup component add rust-analyzer
    # to check that you have it, run `rust-analyzer` in terminal (don't worry about the actual output, just make sure
    # it doesn't output an error)
    rustup
    bacon # runs rust checks, build, tests etc automatically

    protobuf
    coreutils
    neofetch
    zellij

    nerd-fonts.hack

    # Wayland
    fuzzel       # app launcher
    wl-clipboard # used to give neovim access to clipboard (so I can paste stuff into neovim)
    waybar       # status bar (where the workspace numbers are)
    # bluez # bluetooth core tool
    # blueman # bluetooth GUI
    grim         # Takes screenshots
    slurp        # Select area (used for screenshots)
    pwvucontrol  # pipewire audio control GUI (used in waybar)

    # Apps
    spotify
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.zsh = import ./zsh.nix;

  programs.git = {
    enable = true;
    userName = "Alex Georgousis";
    userEmail = "alex.georgousis@hey.com";
    signing = {
      key = "~/.ssh/default";
      signByDefault = true;
    };
    extraConfig = {
      pull.rebase = true;
      push.autoSetupRemote = true;
      rebase.autosquash = true;
      init.defaultBranch = "main";
      gpg = {
        format = "ssh";
        ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      };
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;

    # Options for Ctrl + R (command history search)
    historyWidgetOptions = [
      "--height=10%" # 10% seems to be the minimum
    ];

    # Options for Ctrl + T (File search)
    fileWidgetOptions = [
      # Use bat (cat replacement) in preview window
      "--preview 'bat --style=numbers --color=always --line-range :500 {}'"
    ];

  };

  fonts.fontconfig.enable = true;

  home.username = "alex";
  home.homeDirectory = "/home/alex";

  home.stateVersion = "25.05";
}
