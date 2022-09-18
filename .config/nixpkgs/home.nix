{ config, pkgs, ... }:

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
  ];

  programs.git = {
    enable = true;
    userName = "Alex Georgousis";
    userEmail = "alex.georgousis@outlook.com";
    signing.key = "B770E04EDC3185F9";
    extraConfig.pull.rebase = true;
  };

  programs.vim = {
    enable = true;
  };

  programs.zsh = {
    enable = true;
    dotDir = ".config/zsh";
    enableSyntaxHighlighting = true;
    enableAutosuggestions = true;

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";
      plugins = [
        "git"
        "web-search"
        "vi-mode"
      ];
    };

    initExtra = ''
      bindkey -v                         # enable vi-mode
      bindkey -M viins 'jk' vi-cmd-mode  # map 'jk' to Esc
    '';

    sessionVariables = {
      VI_MODE_SET_CURSOR="true";
      PYTHONDONTWRITEBYTECODE=1;  # don't generate .pyc files (source: https://news.ycombinator.com/item?id=23366924)
      GOOGLE_APPLICATION_CREDENTIALS="$HOME/.config/gcloud/application_default_credentials.json";
    };

    shellAliases = {
      kb="kubectl";
      kbb="kubebuilder";
      ncr="cd /Users/AGI53/repos/glados/disco-ml-nbcu-ncr";
      dep="cd /Users/AGI53/repos/glados/disco-mlops-deployments";
      config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME";
      c="config";
      cgst="config status";
      cga="config add";
      cgc="config commit";
      cgam="config commit -a -m";
      cgp="config push";
      cgd="config diff";
      hm="home-manager";
    };
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
  };
}
