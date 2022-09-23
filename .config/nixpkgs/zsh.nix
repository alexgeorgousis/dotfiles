{

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
    VI_MODE_SET_CURSOR="true";  # changes cursor style in insert mode (in zsh line editor)
    PYTHONDONTWRITEBYTECODE=1;  # don't generate .pyc files (source: https://news.ycombinator.com/item?id=23366924)
    EDITOR = "vim";             # sets default editor for home-manager edit command
    GOOGLE_APPLICATION_CREDENTIALS="$HOME/.config/gcloud/application_default_credentials.json";
    PATH="$HOME/.nix-profile/bin:$HOME/.asdf/shims:$HOME/google-cloud-sdk/bin:$PATH";
  };

  shellAliases = {
    kcuc="kubectl config use-context";
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
    evim="vim $HOME/.config/nixpkgs/.vimrc";
    ezsh="vim $HOME/.config/nixpkgs/zsh.nix";
  };

  shellGlobalAliases = {
    kb="kubectl";  # added to global aliases so that `watch kb ...` works
  };

}
