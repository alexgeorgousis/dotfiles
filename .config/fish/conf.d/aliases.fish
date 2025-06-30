# Basic aliases
alias vim="nvim"
alias ezsh="vim $HOME/.config/zsh/.zshrc"

# Git aliases
alias gst="git status"
alias gl="git pull"
alias gp="git push"
alias gpf='git push --force-with-lease --force-if-includes'
alias glp="git log --pretty=format:'%C(yellow)%h%C(cyan)%x09%an%Creset%x09%C(magenta)%ar%x09%Creset%s' -20"
alias gsw="git switch"
alias gco="git checkout"
alias gcob="git checkout -b"
alias gd="git diff"
alias gau="git add -u"
alias gaa="git add --all"
alias gc="git commit --verbose"
alias gc!="git commit --verbose --amend"
alias gca="git commit add"
alias gcam="git commit add -m"
alias gca!="git commit --verbose --all --amend"
alias gcau!="git commit --verbose -u --amend"
alias grb="git rebase"
alias grbm="git rebase $git_main_branch"
alias grbmi="git rebase $git_main_branch --interactive"
alias grbmc="git rebase --continue"
alias grbma="git rebase --abort"
alias gcm="git checkout $git_main_branch"
alias glp="git log --pretty=format:'%C(yellow)%h%C(cyan)%x09%an%Creset%x09%C(magenta)%ar%x09%Creset%s' -20"
alias grs="git restore"

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
alias cgcm="config checkout arch"
alias cgsw="config switch"
alias cgswm="config switch arch"
alias cgw="config worktree"
alias cgwl="config worktree list"
alias cgwa="config worktree add"
alias cgrb="config rebase"
alias cgrbm="config rebase main"
alias cgrbi="config rebase --interactive"
alias cgrbc="config rebase --continue"
alias cgrba="config rebase --abort"
alias cgrs="config restore"

# CLI alternatives
alias grep="rg"
abbr --add --position anywhere G "| grep -i"
alias ls="eza --group"  # --group displays the group that owns files, which is disabled by default! source: https://github.com/ogham/exa/issues/1118
alias l="ls -la"
alias lt="ls --tree"
alias cat="bat"
alias df="duf"
alias top="htop"
alias ps="procs"
alias mkdir="mkdir -p"
alias watch="watch --color --no-title"; # Visual improvements to the watch comman

# kubectl - use custom env vars to determine current context and namespace instead of kubeconfig file.
alias k="kubectl --context=$KUBECONTEXT --namespace=$KUBENAMESPACE"
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
