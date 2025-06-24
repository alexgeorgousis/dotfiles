# bindkey -v  # enables vi mode - not needed because it's set by zsh-vi-mode

# NOTE: Normally in zsh you can do this with: bindkey -M viins 'jk' vi-cmd-mode
# But that doesn't work with the zsh-vi-mode plugin. Instead they say do this (source: https://github.com/jeffreytse/zsh-vi-mode?tab=readme-ov-file#custom-escape-key).
export ZVM_VI_INSERT_ESCAPE_BINDKEY=jk  # map 'jk' to Esc

# NOTE: The zsh-vi-mode (zvm) plugin has some weird lazy setting of keybinds going on which means it loads keybinds after my entire .zshrc file has been loaded, making them impossible to override.
# Thankfully, the author provides an option to run commands after the plugin has finished initialising (source: https://github.com/jeffreytse/zsh-vi-mode#execute-extra-commands)
# In general, if you want to check what a keybind is set to you can run `bindkey '<key>'`
zvm_after_init_commands+=(
  'source /usr/share/fzf/key-bindings.zsh'
  "bindkey -s '^k' 'fzf-change-k8s-context\n'"  # Function defined in ~/.config/home-manager/zsh_functions
  "bindkey -s '^g' 'git status\n'"            # Ctrl+g clears the terminal and runs git status
  "bindkey -s '^o' 'omz reload\n'"            # Ctrl+o clears the screen and reloads terminal (to get the startup output re-printed)
)
