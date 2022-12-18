# dotfiles

Approach explained in
[The best way to store your dotfiles: A bare Git repository](https://www.atlassian.com/git/tutorials/dotfiles).

## yadm
I'm using [yadm](https://yadm.io/) to manage these dotfiles. Unfortunately there's not a nix package for it yet,
so I've installed it manually under ~/.cli/bin.

TODO: How to make a config file or directory OS-specific

TODO: How to turn a config file into a template

TODO: How to edit a template (and apply the changes)

## iTerm2
### Clear Buffer keybind

This is set to `Cmd`+`k` by default, but I wanted to map `Cmd`+`k` to "Select Split Pane Above"
(along with `Cmd`+`h` `Cmd`+`j`, `Cmd`+`l` for the other directions).
`Cmd`+`Shift`+`k` is mapped to the Clear Buffer command to still allow clearing the terminal,
however `Ctrl`+`l` is easier to press and is not MacOS specific, so it's a better alternative.

Sidenote: Unforutunately, the keybind for the Clear Buffer command can only be configured
[manually via App Shortcuts](https://superuser.com/questions/1154896/remapping-iterm-2s-shortcut-for-clear-buffer)
and not via iTerm2 config, so loading the iTerm2 configuration file is not sufficient.

### .hushlogin
By default, iTerm2 displays a "Last login" message in every new window. Apparently creating an empty `.hushlogin` file
in the home directory is the way to fix it. Strange, but it works.

### Toggling transparency
You can toggle window transparency using `Cmd` + `u` (this hotkey is set in iTerm2 by default). This can be useful
because you can set the transparency to a high value and then quickly turn it off if you move the terminal on top of
another window.
