{

  enable = true;
  dotDir = ".config/zsh";
  enableSyntaxHighlighting = true;
  enableAutosuggestions = true;

  oh-my-zsh = {
    enable  = true;
    theme   = "gozilla";
    plugins = [
      "git"
      "web-search"
      "vi-mode"
    ];
  };

  initExtra = ''
    bindkey -M viins 'jk' vi-cmd-mode  # map 'jk' to Esc
    bindkey -s '^g' 'clear && git status\n'
  '';

  defaultKeymap = "viins";

  sessionVariables = {
    VI_MODE_SET_CURSOR             = "true";  # changes cursor style in insert mode (in zsh line editor)
    PYTHONDONTWRITEBYTECODE        = 1;       # don't generate .pyc files (source: https://news.ycombinator.com/item?id=23366924)
    EDITOR                         = "nvim";  # sets default editor for home-manager edit command
    GOOGLE_APPLICATION_CREDENTIALS = "$HOME/.config/gcloud/application_default_credentials.json";
    XDG_CONFIG_HOME                = "$HOME/.config";
    PATH                           = "$HOME/.nix-profile/bin:$HOME/.asdf/shims:$HOME/google-cloud-sdk/bin:$PATH:$HOME/cli/bin";
  };

  shellAliases = {
    # Aliases for frequently accessed repos
    ncr = "cd $HOME/repos/glados/disco-ml-nbcu-ncr";
    dep = "cd $HOME/repos/glados/disco-mlops-deployments";
    mms = "cd $HOME/repos/glados/disco-ml-model-service";

    # Git aliases
    glp = "git log --pretty=format:'%C(yellow)%h%C(cyan)%x09%an%Creset%x09%C(magenta)%ar%x09%Creset%s' -20";

    # Git aliases for dotfiles
    config  = "yadm";
    c       = "config";
    cgst    = "config status";
    cglg    = "config log --stat";
    cglp    = "config log --pretty=format:'%C(yellow)%h%C(cyan)%x09%an%Creset%x09%C(magenta)%ar%x09%Creset%s' -20";
    cga     = "config add";
    cgau    = "config add --update";  # Stages all currently tracked files
    cgc     = "config commit -v";
    "cgc!"  = "config commit -v --amend";
    cgp     = "config push";
    cgpf    = "config push --force";
    # Doesn't work with the dotfiles bare repo setup - looks for the current branch in a git repo in the current working directory :(
    # cgpsup  = "config push --set-upstream origin $(git_current_branch)";
    cgl     = "config pull";
    cgd     = "config diff";
    cgb     = "config branch";
    cgco    = "config checkout";
    cgcm    = "config checkout main";
    cgrs    = "config restore";

    # Managing dotfiles
    hm   = "home-manager";
    hms  = "home-manager switch";
    hme  = "home-manager edit";
    evim = "vim $HOME/.config/astronvim/lua/user/init.lua";
    ezsh = "vim $HOME/.config/nixpkgs/zsh.nix";

    # exa (improved ls)
    ls  = "exa";
    la  = "exa --all";
    lt  = "exa --tree";
    ll  = "exa --long --group --git";
    lla = "exa --long --group --git --all";
    llt = "exa --long --group --git --tree";

    # CLI alternatives
    cat  = "bat";
    find = "fd";
    df   = "duf";
    top  = "htop";
  };

  # Global aliases work anywhere in a command (e.g. `watch k get pods`)
  shellGlobalAliases = {
    k    = "kubectl";
    kd   = "kubectl describe";
    kccc = "kubectl config current-context";
    kcgc = "kubectl config get-contexts";
    kcuc = "kubectl config use-context";
  };

}
