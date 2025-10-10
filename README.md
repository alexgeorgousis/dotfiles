# Dotfiles

Personal dotfiles for Omarchy Linux managed with chezmoi.

# Gaming

## Play Battle.net Games Via Steam

Reddit guide: https://www.reddit.com/r/linux_gaming/comments/1hpj9af/running_blizzard_battlenet_games_using_steamproton/

1. Download the [battle.net](https://download.battle.net/?product=bnetdesk) installer
2. In steam, go to games > add non steam game, choose the installer it will add Battle.net-setup.exe to your library.
3. In the steam library, right click Battle.net-setup.exe -> properties  -> compatibility -> tick Force the use of a specific Steam Play compatibility tool -> Proton 10.0-2 (beta) - I had issues with non-beta versions.
4. Click Play and Battle.net will install and run.
5. So that you don't run the installer each time, make it run the battle.net launcher instead of the installer. Fully exit battle.net, then run `find ~/.local/share/Steam/ -name 'Battle.net Launcher.exe'` to get the full path to the launcher executable.
6. In the steam library, right click Battle.net-setup.exe again and press properties, then in the target field enter the path you got from the find command. Be sure to enclose it in single quotes (because the filename has a space in it), it should look something like '/home/<user>/.local/share/Steam/steamapps/compatdata/4232122757/pfx/drive_c/Program Files (x86)/Battle.net/Battle.net Launcher.exe'
7. Now when you run it from Steam, the launcher should open and you're ready to install your games.

## (Old) Lutris Attempt

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

### 4. Install Wine dependencies (.NET and browser support)

```bash
sudo pacman -S wine-mono wine-gecko winetricks
sudo systemctl restart systemd-binfmt
```

**Important:** Restart Lutris completely after installing these packages to ensure library detection.

### 5. Install .NET Framework and Visual C++ runtimes in Wine prefix

Battle.net installer requires .NET Framework 4.8 and Visual C++ 2019 runtime.

Error without this (test by running installer manually):
```bash
export WINEPREFIX=$HOME/Games/battlenet && $HOME/.local/share/lutris/runners/wine/wine-ge-8-26-x86_64/bin/wine $HOME/.cache/lutris/installer/battlenet/setup/Battle.net-Setup.exe
```

Error message:
```
wine: failed to open "$HOME/.cache/lutris/installer/battlenet/setup/Battle.net-Setup.exe": c0000135
```

(Error code `c0000135` = missing DLL)

Solution - install runtimes using winetricks:
```bash
# Install .NET Framework 4.8 (takes 5-10 minutes, lots of warnings are normal)
WINEPREFIX=$HOME/Games/battlenet winetricks dotnet48

# Install Visual C++ 2019 runtime
WINEPREFIX=$HOME/Games/battlenet winetricks vcrun2019
```

After these installations, the Battle.net installer should work in Lutris.
