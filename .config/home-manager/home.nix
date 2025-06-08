{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the
  # paths it should manage.
  home.username = "agi53";
  home.homeDirectory = "/home/agi53";

  home.stateVersion = "22.05";

  # Packages that should be installed to the user profile
  home.packages = with pkgs; [
    neovim
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
    # yq from nix has issues for some reason, so I installed it manually
    # yq
    asdf-vm
    docker
    colima # docker runtime - open source replacement for Docker Desktop app
    k9s # config in ~/.config/k9s/config.yaml
    argo
    argocd
    gopls  # go language server
    kubernetes-helm
    docker-compose
    # used to manage rust - includes rust compiler, cargo pkg manager, and rust-analyzer LSP server
    # to use rust-analyzer you'll need to install it with rustup component add rust-analyzer
    # to check that you have it, run `rust-analyzer` in terminal (don't worry about the actual output, just make sure
    # it doesn't output an error)
    rustup
    zig # I currently use zig to cross-compile rust code (lol)
    bacon # runs rust checks, build, tests etc automatically
    protobuf
    kubecolor
    coreutils # only used for Cid development
    # fluxcd # flux CLI tool - the most recent version of the nix pkg has hardcoded apiVersion of helmrelease kind, which is lower than what we have in our clusters, so I had to download a lower version with homebrew using: brew install fluxcd/tap/flux@2.1
    helmsman # used to run minikube tests for bibcd-genesys modules
    vault # used by Content Discovery teams to manage secrets - homepage: https://www.vaultproject.io/
    git-crypt # used to read secrets in bibcd repo as a maintainer: https://github.com/sky-uk/bibcd/blob/master/docs/maintainer-guide/maintainer-secret-management.md
    twine # used to manually publish the BiBCD 1.0 deployer for testing
    jenkins # used to run Jenkins locally (for BiBCD development work) - run using jenkins-cli
    ansible # used to run operations on K8s nodes remotely - referenced in jenkins maintainers runbook
    sshpass # used by ansible for ssh authentication
    awscli2
    nodejs_20
    neofetch
    # this is required by ruby, which I need to build the career matrix website locally, which is in the prs-engineering repo (basically, a very niche use case)
    libyaml
    gh
    kubebuilder
    terraform
    xclip # used to give neovim access to clipboard (so I can paste stuff into neovim)
    zellij
    fuzzel
    nerd-fonts.hack
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.zsh = import ./zsh.nix;

  programs.git = {
    enable = true;
    userName = "Alex Georgousis";
    userEmail = "alex.georgousis@sky.uk";
    signing = {
      key = "~/.ssh/default";
      signByDefault = true;
    };
    extraConfig = {
      pull.rebase = true;
      push.autoSetupRemote = true;
      rebase.autosquash = true; # automatically squash fixup commits
      init.defaultBranch = "main";
      gpg = {
        format = "ssh";
        ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      };
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
      "--height=10%" # 10% seems to be the minimum
    ];

    # Options for Ctrl + T (File search)
    fileWidgetOptions = [
      # Use bat (cat replacement) in preview window
      "--preview 'bat --style=numbers --color=always --line-range :500 {}'"
    ];

  };

  programs.vscode = {
    enable = true;
    profiles.default = {
      extensions = with pkgs.vscode-extensions; [
        vscodevim.vim
        golang.go
        ms-python.python
        rust-lang.rust-analyzer
        github.copilot
        tamasfe.even-better-toml
        eamodio.gitlens
        enkia.tokyo-night
        hediet.vscode-drawio
      ];
      userSettings = {
        "vim.vimrc.enable" = true;
        "vim.vimrc.path" = "$HOME/.config/vscode/vimrc";
        # -- vscode neovim extension settings -- #
        # I commented them out because lsp features don't work out of the box for some reason (I get an error saying the lsp server isn't attached)
        # TODO: I tried using $HOME here instead of hardcoding the full path, but the plugin threw an error for some reason :shrug: 
        # "vscode-neovim.neovimExecutablePaths.darwin" = "/Users/agi53/.nix-profile/bin/nvim";
        # No clue what this setting does, but it's part of the vscode neovim extension installation instructions (https://github.com/vscode-neovim/vscode-neovim#installation)
        # "extensions.experimental.affinity" = {
        #   "asvetliakov.vscode-neovim" = 1;
        # };
        "editor.minimap.enabled" = false;
        "workbench.startupEditor" = "none";
        "editor.formatOnSave" = true;
        "extensions.ignoreRecommendations" = true;
        "git.openRepositoryInParentFolders" = "never";
        "window.openFoldersInNewWindow" = "on";
        "workbench.activityBar.location" = "hidden";
        "extensions.autoUpdate" = false;
        "update.showReleaseNotes" = false;
        "workbench.colorTheme" = "Tokyo Night Storm";
        "[toml]" = {
          "editor.formatOnSave" = false;
        };
        "files.watcherExclude" = {
          "**/.bloop" = true;
          "**/.metals" = true;
          "**/.ammonite" = true;
        };
        "github.copilot.enable" = {
          "scala" = false;
        };
        "gopls" = {
          "buildFlags" = ["-tags=unit,decoupled,integration,integrated,acceptance"];
        };
      };
      keybindings = [
          {
            key = "ctrl+shift+cmd+v";
            command = "toggleVim";
          }
          # The combination of the following 2 keybindings maps jk to escape in insert mode (https://github.com/vscode-neovim/vscode-neovim#composite-escape-keys)
          {
            command = "vscode-neovim.compositeEscape1";
            key = "j";
            when = "neovim.mode == insert && editorTextFocus";
            args = "j";
          }
          {
            command = "vscode-neovim.compositeEscape2";
            key = "k";
            when = "neovim.mode == insert && editorTextFocus";
            args = "k";
          }
      ];
    };
  };

  programs.sbt = {
    enable = true;
  };
}
