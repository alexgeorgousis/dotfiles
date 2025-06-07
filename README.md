# dotfiles

Approach explained in
[The best way to store your dotfiles: A bare Git repository](https://www.atlassian.com/git/tutorials/dotfiles).

# Fonts
## How to set up Nerd Fonts
[Nerd Fonts](https://www.nerdfonts.com/font-downloads) are fonts that have been extended (patched) with icons that can be displayed inside terminal emulators.

### Tutorial
Source: https://www.youtube.com/watch?v=mQdB_kHyZn8

The steps are the following:
1. Download a font (collection of `.ttf` files) from the [Nerd Fonts website](https://www.nerdfonts.com/font-downloads)
2. Move all `.ttf` files to `~/.local/share/fonts` (create the `fonts` directory manually if it doesn't already exist)
3. Configure your terminal emulator to use the font - For Alacritty, edit the `alacritty.yml` file to set the `font.normal.family` property to the font you want, e.g.:
  ```
  font:
    normal:
      family: "Hack Nerd Font"
  ```
  
### Notes
- While there are nixpkgs for Nerd Fonts, I haven't figured out an easy way to install them via home manager and make them work. But since fonts are just files, I can install them once manually and then add them to this repo, so it's not a big deal.

- If you've setup your dotfiles from this repo, you should already have the [Hack Nerd Font](https://www.programmingfonts.org/#hack) set up with Alacritty.

# Troubleshooting
