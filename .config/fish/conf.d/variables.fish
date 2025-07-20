###############
# FISH CONFIG #
###############

# Enable vi mode :)
set -g fish_key_bindings fish_vi_key_bindings

# Set the time that fish waits after you type a key that's part of a sequence to see if the rest of that sequence is coming or not (example: jk to change from insert to normal mode).
set fish_sequence_key_delay_ms 200

# Remove the fish welcome message at the top of every new session
set fish_greeting ""


#########################
# ENVIRONMENT VARIABLES #
#########################

# NOTE: -g is --global and -x is --export - read more here: https://fishshell.com/docs/current/language.html#shell-variables

set -gx EDITOR nvim
set -gx PATH ~/.asdf/shims ~/.rbenv/shims ~/bin ~/scripts $PATH

# For some reason (I don't know why), GEM_HOME is set globally to an empty list, which causes issues with rbenv, so I have to unset it explictly.
set -e GEM_HOME
