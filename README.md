# Dotfiles

Personal dotfiles for Omarchy Linux (Arch-based) managed with chezmoi.

## System Setup

### Gaming / Lutris / Wine Setup

For running Windows games through Lutris (e.g., Battle.net, WoW), you need 32-bit graphics and font libraries:

```bash
# 32-bit Vulkan drivers (for DXVK translation layer)
sudo pacman -S lib32-vulkan-icd-loader lib32-vulkan-radeon

# 32-bit FreeType fonts (for Wine applications)
# Error without this:
# Wine cannot find the FreeType font library.  To enable Wine to
# use TrueType fonts please install a version of FreeType greater than
# or equal to 2.0.5.
# Initial process has exited (return code: 256)
sudo pacman -S lib32-freetype2
```

**Note:** Replace `lib32-vulkan-radeon` with `lib32-vulkan-intel` or `lib32-nvidia-utils` if using Intel or NVIDIA GPU.
