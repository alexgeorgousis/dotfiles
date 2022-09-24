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
    istioctl
    asdf-vm
  ];

  programs.zsh = import ./zsh.nix;

  programs.git = {
    enable = true;
    userName = "Alex Georgousis";
    userEmail = "alex.georgousis@outlook.com";
    signing.key = "B770E04EDC3185F9";
    extraConfig.pull.rebase = true;
  };

  programs.vim = {
    enable = true;
    extraConfig = builtins.readFile ./.vimrc;
    # Note: vim-sensible is included by default, but I've enabled it explicitly for transparency.
    plugins = with pkgs.vimPlugins; [
      vim-sensible
      auto-pairs
    ];
  };

  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    historyWidgetOptions = [ "--height=10%" ];  # 10% seems to be the minimum
  };

  programs.vscode = {
    enable = true;
    extensions = with pkgs.vscode-extensions; [
      vscodevim.vim
      ms-python.python
      eamodio.gitlens
      scalameta.metals
      zxh404.vscode-proto3
    ];
    userSettings = {
      "vim.vimrc.enable" = true;
      "vim.vimrc.path" = "$HOME/.config/nixpkgs/.vimrc";
    };
  };

}
