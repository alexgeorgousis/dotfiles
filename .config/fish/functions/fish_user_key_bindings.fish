function fish_user_key_bindings
        # Normal mode is called "default" in fish
        # To see all modes run `bind --list-modes` in the terminal
        bind --mode insert jk 'set fish_bind_mode default'
end
