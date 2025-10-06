# Dotfiles

Personal dotfiles for Omarchy Linux managed with chezmoi.

## Gaming / Lutris / Wine Setup

For running Windows games through Lutris (e.g., Battle.net, WoW), you need 32-bit graphics and font libraries.

### 1. Install 32-bit Vulkan drivers (for DXVK translation layer)

```bash
sudo pacman -S lib32-vulkan-icd-loader lib32-vulkan-radeon
```

**Note:** Replace `lib32-vulkan-radeon` with `lib32-vulkan-intel` or `lib32-nvidia-utils` if using Intel or NVIDIA GPU.

### 2. Install 32-bit FreeType fonts

Error without this:
```
Wine cannot find the FreeType font library.  To enable Wine to
use TrueType fonts please install a version of FreeType greater than
or equal to 2.0.5.
Initial process has exited (return code: 256)
```

Solution:
```bash
sudo pacman -S lib32-freetype2
```

### 3. Install 32-bit OpenGL, Vulkan, and TLS libraries

Error without this (check with `tail -100 ~/.cache/lutris/lutris.log`):
```
[ERROR:2025-10-06 08:53:08,756:startup]: i386 libGL.so.1 missing (needed by opengl)
[ERROR:2025-10-06 08:53:08,756:startup]: i386 libvulkan.so.1 missing (needed by vulkan)
[ERROR:2025-10-06 08:53:08,756:startup]: i386 libgnutls.so.30 missing (needed by gnutls)
```

Solution:
```bash
sudo pacman -S lib32-mesa lib32-gnutls
```
