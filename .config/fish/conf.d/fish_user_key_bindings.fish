function fish_user_key_bindings
        # Normal mode is called "default" in fish
        # To see all modes run `bind --list-modes` in the terminal
        # backward-char - ensures the cursor moves 1 char back when switching to Normal mode
        # repaint - redraws the prompt to reprint the mode indication
        bind --mode insert --sets-mode default jk backward-char repaint-mode

        bind --mode default \cg clear-screen "git status" repaint
        bind --mode insert \cg clear-screen "git status" repaint
        bind --mode visual \cg clear-screen "git status" repaint

        bind --mode default \cf ~/scripts/find-project
        bind --mode insert \cf ~/scripts/find-project
        bind --mode visual \cf ~/scripts/find-project

        fzf --fish | source
end
