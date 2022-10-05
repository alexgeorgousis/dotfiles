{ config, pkgs, ... }:

let
  # Manually package CtrlSF vim plugin
  ctrlsf = pkgs.vimUtils.buildVimPlugin {
    name = "ctrlsf";
    src = pkgs.fetchFromGitHub {
      owner = "dyng";
      repo = "ctrlsf.vim";
      rev = "master";
      /* 
       * I'm not sure what this SHA-256 is used for and I didn't know how to generate it.
       * I left it blank and home-manager switch threw an error saying "expected <...>"
       * so I just copy-pasted the SHA it said it expected. ¯\_(ツ)_/¯
       */
      sha256 = "td8eE5t1t5xBAxYq19U5fQXMXS1ZIxAzl2Q6nsIRR6Q=";
    };
  };
in
{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "AGI53";
  home.homeDirectory = "/Users/AGI53";

  # This value determines the Home Manager release that your
  # configuration is compatible with. This helps avoid breakage
  # when a new Home Manager release introduces backwards
  # incompatible changes.
  #
  # You can update Home Manager without changing this value. See
  # the Home Manager release notes for a list of state version
  # changes in each release.
  home.stateVersion = "22.05";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  # Packages that should be installed to the user profile
  home.packages = with pkgs; [
    grpcui
    grpcurl
    ghz
    docker
    kubectl
    kubernetes-helm
    watch
    openconnect
    istioctl
    asdf-vm
    vifm             # vim-like file manager
    pre-commit
    silver-searcher  # used by FZF (:Ag) and CtrlSF to search for text in files
    k9s
    exa              # prettier ls
    bat              # prettier cat
    fd               # prettier and better find
    duf              # prettier alternative to df - displays disk usage
    htop             # process viewer - alternative to top
    nerdfonts
  ];

  programs.zsh = import ./zsh.nix;

  programs.git = {
    enable = true;
    userName = "Alex Georgousis";
    userEmail = "alex.georgousis@outlook.com";
    signing.key = "B770E04EDC3185F9";
    extraConfig = {
      pull.rebase = true;
      rebase.autosquash = true;  # automatically squash fixup commits
      diff.tool = "vimdiff";     # run `git difftool [-y]` to get side-by-side diff using vimdiff
    };

    diff-so-fancy = {
      enable = true;
    };

  };

  programs.neovim = {
    enable = true;
    vimAlias = true;
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;

    # Options for Ctrl + R (command history search)
    historyWidgetOptions = [
      "--height=10%"  # 10% seems to be the minimum
    ];

    # Options for Ctrl + T (File search)
    fileWidgetOptions = [
      # Use bat in preview window
      "--preview 'bat --style=numbers --color=always --line-range :500 {}'"
    ];

  };

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      ms-python.python
      eamodio.gitlens
      scalameta.metals
      zxh404.vscode-proto3
      dracula-theme.theme-dracula
    ];
    userSettings = {
      "vim.vimrc.enable" = true;
      "vim.vimrc.path" = "$HOME/.config/nvim.bak/vimrc";
      "editor.minimap.enabled"  = false;
      "workbench.startupEditor" = "none";
      "editor.formatOnSave" = true;
      "workbench.colorTheme" = "Dracula";
      "files.watcherExclude" = {
        "**/.bloop"    = true;
        "**/.metals"   = true;
        "**/.ammonite" = true;
        };
    };
  };

  programs.sbt = {
    enable = true;
  };

}
