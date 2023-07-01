{ config, pkgs, ... }:

{
  home.username = "alex";
  home.homeDirectory = "/home/alex";
  home.stateVersion = "22.11";

  # Packages that should be installd to the user profile
  home.packages = with pkgs; [
    neovim
    asdf-vm
    xcape
    neofetch
    exa
    bat
    fd
    nmap
    gobuster
    ripgrep
    procs
    colima
    docker
    kubectl
    
    # Rust  #
    rustup
    protobuf  # command name: protoc - used to generate definitions from .proto files
    # /Rust #

    # Tmp
    # /Tmp
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Three manual steps are needed to set zsh as the default shell:
  #   1. command -v zsh | sudo tee --append /etc/shells (append zsh path to shells file)
  #   2. sudo chsh --shell $(which zsh) $USER (change shell to zsh for current user)
  #   3. Logout and log back in for changes to take effect
  programs.zsh = import ./zsh.nix;

  programs.zellij = {
    enable = true;  
  };

  programs.nushell = {
    enable = true;
  };
  
  programs.git = {
    enable = true;
    userName = "Alex Georgousis";
    userEmail = "alex.georgousis@outlook.com";
    extraConfig = {
      pull.rebase = true;
      push.autoSetupRemote = true;
      rebase.autosquash = true;  # automatically squash fixup commits
      diff.tool = "vimdiff";     # run `git difftool [-y]` to get side-by-side diff using vimdiff
    };
    diff-so-fancy = {
      enable = true;
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;

    # Options for Ctrl + R (command history search)
    historyWidgetOptions = [
      "--height=5%"
    ];

    # Options for Ctrl + T (File search)
    fileWidgetOptions = [
      # Use bat in preview window
      "--preview 'bat --style=numbers --color=always --line-range :500 {}'"
    ];
  };
}
