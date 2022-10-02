# dotfiles

Approach explained in
[The best way to store your dotfiles: A bare Git repository](https://www.atlassian.com/git/tutorials/dotfiles).

## iTerm2
Note about Clear Buffer keybind (`Cmd`+`k` by default)

`Cmd`+`k` is mapped to "Select Split Pane Above" (along with `Cmd`+`h` `Cmd`+`j`, `Cmd`+`l` for the other directions).
`Cmd`+`Shift`+`k` is mapped to the Clear Buffer command to still allow clearing the terminal,
however `Ctrl`+`l` is easier to press and is not MacOS specific, so it's a better alternative.

Sidenote: Unforutunately, the keybind for the Clear Buffer command can only be configured
[manually via App Shortcuts](https://superuser.com/questions/1154896/remapping-iterm-2s-shortcut-for-clear-buffer)
and not via iTerm2 config, so loading the iTerm2 configuration file is not sufficient.

