{
  enable = true;
  dotDir = ".config/zsh";
  enableSyntaxHighlighting = true;
  enableAutosuggestions = true;

  oh-my-zsh = {
    enable  = true;
    theme   = "simple";
    plugins = [
      "git"
      "web-search"
      "vi-mode"
    ];
  };

  initExtra = ''
    source ~/.xprofile                 # maps CapsLock to Esc and Ctrl
    bindkey -M viins 'jk' vi-cmd-mode  # map 'jk' to Esc
    bindkey -s '^g' 'clear && git status\n'
    neofetch                           # displays pretty ascii
  '';

  defaultKeymap = "viins";

  sessionVariables = {
    VI_MODE_SET_CURSOR             = "true";  # changes cursor style in insert mode (in zsh line editor)
    PYTHONDONTWRITEBYTECODE        = 1;       # don't generate .pyc files (source: https://news.ycombinator.com/item?id=23366924)
    EDITOR                         = "nvim";  # sets default editor for home-manager edit command
    GOOGLE_APPLICATION_CREDENTIALS = "$HOME/.config/gcloud/application_default_credentials.json";
    XDG_CONFIG_HOME                = "$HOME/.config";
    PATH                           = "$HOME/.nix-profile/bin:$HOME/.asdf/shims:$HOME/google-cloud-sdk/bin:$HOME/cli/bin:$PATH";
    NIX_PATH                       = "$HOME/.nix-defexpr/channels:/nix/var/nix/profiles/per-user/root/channels:$NIX_PATH";  # required by home-manager
    # This is meant to speed up rust compile times by caching already built artifacts
    # However, I get an error when running cargo build in a rust project, so I'm disabling it until that's resolved
    # RUSTC_WRAPPER                  = "$HOME/.cargo/bin/sccache cargo install {package}";                                    # (source: https://www.youtube.com/watch?v=dFkGNe4oaKk)
  };

  shellAliases = {
    
    # Aliases for frequently accessed repos
    kfp = "cd $HOME/repos/kfp-rust/";

    # Git aliases
    glp  = "git log --pretty=format:'%C(yellow)%h%C(cyan)%x09%an%Creset%x09%C(magenta)%ar%x09%Creset%s' -20";
    gw   = "git worktree";
    gwl  = "git worktree list";
    gwa  = "git worktree add";

    # Git aliases for dotfiles
    config  = "$(which git) --git-dir=$HOME/.cfg --work-tree=$HOME";
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
    cgw     = "config worktree";
    cgwl    = "config worktree list";
    cgwa    = "config worktree add";
    grbm   = "config rebase main";
    cgrs    = "config restore";
    cls     = "config ls-tree --name-only -r HEAD";

    # Managing dotfiles
    hm   = "home-manager";
    hms  = "home-manager switch";
    hme  = "vim ~/.config/nixpkgs/home.nix";
    ezsh = "vim $HOME/.config/nixpkgs/zsh.nix";
    evim = "vim $HOME/.config/astronvim/lua/user/init.lua";

    # zellij
    z  = "zellij";
    za = "zellij attach";

    # CLI alternatives
    ls    = "exa";
    la    = "exa --all";
    lt    = "exa --tree";
    ll    = "exa --long --group --git";
    lla   = "exa --long --group --git --all";
    llt   = "exa --long --group --git --tree";
    llta  = "exa --long --group --git --tree --all";
    cat   = "bat";
    find  = "fd";
    df    = "duf";
    top   = "htop";
    ps    = "procs";
    mkdir = "mkdir -p";

  };

  # Global aliases work anywhere in a command (e.g. `watch k get pods`)
  shellGlobalAliases = {
    vim = "nvim";

    # kubectl
    k    = "kubectl";
    kd   = "kubectl describe";
    kccc = "kubectl config current-context";
    kcgc = "kubectl config get-contexts";
    kcuc = "kubectl config use-context";
    
    grep = "rg";
    G    = "|rg";
  };
}
