# Git aliases
alias glp="git log --pretty=format:'%C(yellow)%h%C(cyan)%x09%an%Creset%x09%C(magenta)%ar%x09%Creset%s' -20"

# Git aliases for dotfiles
alias config="$(which git) --git-dir=$HOME/.cfg --work-tree=$HOME"
alias c="config"
alias cgst="config status"
alias cglg="config log --stat"
alias cglp="config log --pretty=format:'%C(yellow)%h%C(cyan)%x09%an%Creset%x09%C(magenta)%ar%x09%Creset%s' -20"
alias cga="config add"
alias cgap="config add --patch"; # This will prompt you to add (or not add) each hunk of a file independently, so you can choose to only add certain hunks, and then you can restore the rest
alias cgau="config add --update"; # Stages all currently tracked file
alias cgc="config commit -v"
alias "cgc!"="config commit -v --amend"
alias cgp="config push"
alias cgpf="config push --force"
alias cgl="config pull"
alias cgd="config diff"
alias cgb="config branch"
alias cgco="config checkout"
alias cgcm="config checkout main"
alias cgw="config worktree"
alias cgwl="config worktree list"
alias cgwa="config worktree add"
alias cgrb="config rebase"
alias cgrbm="config rebase main"
alias cgrbi="config rebase --interactive"
alias cgrbc="config rebase --continue"
alias cgrba="config rebase --abort"
alias cgrs="config restore"

# Managing dotfiles
alias vim="nvim"
alias ezsh="vim $HOME/.config/zsh/.zshrc"

# CLI alternatives
alias grep="rg"
alias -g G="|rg -i"
alias ls="eza --group"  # --group displays the group that owns files, which is disabled by default! source: https://github.com/ogham/exa/issues/1118
alias lt="ls --tree"
alias cat="bat"
alias df="duf"
alias top="htop"
alias ps="procs"
alias mkdir="mkdir -p"
alias watch="watch --color --no-title"; # Visual improvements to the watch comman

# kubectl - use kubecolor for colouring and use custom env vars to determine current context and namespace instead of kubeconfig file.
alias k="kubecolor --context=$KUBECONTEXT --namespace=$KUBENAMESPACE"
alias kgp="k get pods"
alias kd="k describe"
alias kdl="k delete"
alias kc="k config"
alias kccc="k config current-context"
alias kcgc="k config get-contexts"
alias kcuc="k config use-context"

# Start k9s using the kubectl context and namespace set in the relevant env vars
# Note: I named the alias ks instead of k9s so I can still run the k9s CLI without passing the context and namespace flags. This allows me to run things like `k9s version`, `k9s info` etc. (otherwise it complains).
alias ks="k9s --context=$KUBECONTEXT --namespace=$KUBENAMESPACE"

# Make other k8s tools get kube context and namespace from env vars like kubectl
alias argo="argo --context=$KUBECONTEXT --namespace=$KUBENAMESPACE"
alias helm="helm --namespace=$KUBENAMESPACE"
