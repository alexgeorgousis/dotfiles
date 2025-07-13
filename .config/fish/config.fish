# Needed for rbenv to work properly in fish shell
status --is-interactive; and rbenv init - --no-rehash fish | source

# Set up fzf
fzf --fish | source
