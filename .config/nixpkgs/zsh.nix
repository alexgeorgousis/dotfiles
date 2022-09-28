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
    kccc="kubectl config current-context";
    kcgc="kubectl config get-contexts";
    kcuc="kubectl config use-context";
    ncr="cd $HOME/repos/glados/disco-ml-nbcu-ncr";
    dep="cd $HOME/repos/glados/disco-mlops-deployments";
    mms="cd $HOME/repos/glados/disco-ml-model-service";
    config="/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME";
    c="config";
    cgst="config status";
    cglg="config log --stat";
    cga="config add";   
    cgau="config add --update";  # Adds all currently tracked files
    cgc="config commit -v";
    "cgca!"="config commit -v -a --amend";
    cgp="config push";
    cgpf="config push --force";
    cgl="config pull";
    cgd="config diff";
    hm="home-manager";  
    hms="home-manager switch";  
    hme="home-manager edit";  
    evim="vim $HOME/.config/nixpkgs/.vimrc";
    ezsh="vim $HOME/.config/nixpkgs/zsh.nix";
  };

  shellGlobalAliases = {
    # These aliases will work in the middle of a command (e.g. `watch k get pods`)
    k="kubectl";
    kd="kubectl describe";
  };

}
