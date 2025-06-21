{
  enable = true;
  dotDir = ".config/zsh";
  syntaxHighlighting.enable = true;
  autosuggestion.enable = true;

  oh-my-zsh = {
    enable = true;
    theme = "gozilla";
    custom = "$HOME/.config/zsh/oh-my-zsh/custom";
    plugins = [
      "git"
      "web-search"
      "vi-mode"
      "kubectl"
    ];
  };

  initContent = ''
    bindkey -M viins 'jk' vi-cmd-mode           # map 'jk' to Esc
    bindkey -s '^g' 'git status\n'            # Ctrl+g clears the terminal and runs git status
    bindkey -s '^o' 'omz reload\n'            # Ctrl+o clears the screen and reloads terminal (to get the startup output re-printed)
    bindkey -s '^k' 'fzf-change-k8s-context\n'  # Function defined in ~/.config/home-manager/zsh_functions

    # Setup ssh
    eval "$(ssh-agent -s)" 1>/dev/null
    find ~/.ssh -type f ! -name '*.pub' -exec ssh-add {} 2>/dev/null \; # this weird looking command finds all private ssh keys in ~/.ssh and adds them with ssh-add

    # Customise zsh prompt
    function kubectl_prompt() {
      local color="green"
      if [[ "$KUBECONTEXT" == *"prod"* ]]; then
        color="red"
      fi
      echo "%{$fg[$color]%}[$KUBECONTEXT/$KUBENAMESPACE]%{$reset_color%}✨"
    }
    PROMPT="%(?:%{$fg_bold[green]%}➜ :%{$fg_bold[red]%}➜ ) %{$fg[cyan]%}%c%{$reset_color%} "
    PROMPT+='$(git_prompt_info) '
    PROMPT+='$(kubectl_prompt) '

    # Functions used as commands (moved to separate file because nix doesn't like some special bash characterslike '@'
    source ~/.config/home-manager/zsh_functions
  '';

  profileExtra = ''
   if [[ "$XDG_CURRENT_DESKTOP" != "Hyprland" ]]; then
     exec Hyprland
   fi
  '';

  defaultKeymap = "viins";

  sessionVariables = {
    PATH = "$HOME/bin:$HOME/.asdf/shims:$PATH";

    # You can get the value of GOPATH by doing `go env GOPATH`. For some reason though, I can't do `GOPATH = "$(go env GOPATH)";` here
    # (I get `command not found: go`). So I set it manually. Same with GOBIN.
    GOPATH = "$HOME/.asdf/installs/golang/1.22.8/packages";
    GOBIN = "$HOME/.asdf/installs/golang/1.22.8/bin";

    VI_MODE_SET_CURSOR = "true"; # changes cursor style in insert mode (in zsh line editor)

    EDITOR = "nvim";

    # TL;DR: Fixes `Cannot connect to the Docker daemon at unix:///var/run/docker.sock. Is the docker daemon running?` error.
    # Source: https://github.com/abiosoft/colima/blob/main/docs/FAQ.md#cannot-connect-to-the-docker-daemon-at-unixvarrundockersock-is-the-docker-daemon-running
    # Set the location that colima (docker runtime) sets up the docker socket.
    # This is needed because the default location for the docker socket is unix:///var/run/docker.sock whereas
    # colima sets it to unix:///Users/$HOME/.config/colima/default/docker.sock, and some applications (e.g. minikube) expect it to be at the
    # default location, so they fail.
    DOCKER_HOST = "unix://$HOME/.config/colima/default/docker.sock";

    KUBECONFIG = "$HOME/.kube/config";

    # Used to determine the context and namespace to use for kubectl.
    # They are used by the kubectl alias, k, below which is used as an alternative to reading the current context and namespace from the kubeconfig file.
    # They are updated using the kctx and kns functions (defined in ~/.config/home-manager/zsh_functions)
    KUBECONTEXT = "minikube";
    PREV_KUBECONTEXT = "minikube";  # this is set by the `kctx -` command. I'm setting a default here because otherwise when I switch context for the first time and then do `kctx -` PREV_KUBECONTEXT will be empty so it's not able to switch back.
    KUBENAMESPACE = "default";
    PREV_KUBENAMESPACE = "default";  # similar as above but used by `kns -` instead of `kctx -`
  };

  shellAliases = {
    # Git aliases
    glp = "git log --pretty=format:'%C(yellow)%h%C(cyan)%x09%an%Creset%x09%C(magenta)%ar%x09%Creset%s' -20";
    gw = "git worktree";
    gwl = "git worktree list";
    gwa = "git worktree add";

    # Git aliases for dotfiles
    config = "$(which git) --git-dir=$HOME/.cfg --work-tree=$HOME";
    c = "config";
    cgst = "config status";
    cglg = "config log --stat";
    cglp = "config log --pretty=format:'%C(yellow)%h%C(cyan)%x09%an%Creset%x09%C(magenta)%ar%x09%Creset%s' -20";
    cga  = "config add";
    cgap = "config add --patch"; # This will prompt you to add (or not add) each hunk of a file independently, so you can choose to only add certain hunks, and then you can restore the rest!
    cgau = "config add --update"; # Stages all currently tracked files
    cgc = "config commit -v";
    "cgc!" = "config commit -v --amend";
    cgp = "config push";
    cgpf = "config push --force";
    # Doesn't work with the dotfiles bare repo setup - looks for the current branch in a git repo in the current working directory :(
    # cgpsup  = "config push --set-upstream origin $(git_current_branch)";
    cgl = "config pull";
    cgd = "config diff";
    cgb = "config branch";
    cgco = "config checkout";
    cgcm = "config checkout main";
    cgw = "config worktree";
    cgwl = "config worktree list";
    cgwa = "config worktree add";
    cgrb = "config rebase";
    cgrbm = "config rebase main";
    cgrbi = "config rebase --interactive";
    cgrbc = "config rebase --continue";
    cgrba = "config rebase --abort";
    cgrs = "config restore";

    # Managing dotfiles
    vim = "nvim";
    hm = "home-manager";
    hms = "home-manager switch";
    hme = "vim $HOME/.config/home-manager/home.nix";
    ezsh = "vim $HOME/.config/home-manager/zsh.nix";

    # CLI alternatives
    grep = "rg";
    ls = "eza";
    la = "eza --all";
    lt = "eza --tree";
    ll = "eza --long --group --git";
    lla = "eza --long --group --git --all";
    llt = "eza --long --group --git --tree";
    cat = "bat";
    df = "duf";
    top = "htop";
    ps = "procs";
    mkdir = "mkdir -p";
    watch = "watch --color --no-title"; # Visual improvements to the watch command

    # kubectl - use kubecolor for colouring and use custom env vars to determine current context and namespace instead of kubeconfig file.
    k    = "kubecolor --context=$KUBECONTEXT --namespace=$KUBENAMESPACE";
    kgp  = "k get pods";
    kd   = "k describe";
    kdl  = "k delete";
    kc   = "k config";
    kccc = "k config current-context";
    kcgc = "k config get-contexts";
    kcuc = "k config use-context";

    # Start k9s using the kubectl context and namespace set in the relevant env vars
    # Note: I named the alias ks instead of k9s so I can still run the k9s CLI without passing the context and namespace flags. This allows me to run things like `k9s version`, `k9s info` etc. (otherwise it complains).
    ks = "k9s --context=$KUBECONTEXT --namespace=$KUBENAMESPACE";

    # Make other k8s tools get kube context and namespace from env vars like kubectl
    argo    = "argo --context=$KUBECONTEXT --namespace=$KUBENAMESPACE";
    helm    = "helm --namespace=$KUBENAMESPACE";
  };

  # Global aliases work anywhere in a command (e.g. `watch k get pods`)
  shellGlobalAliases = {
    G = "|rg -i";
  };
}
