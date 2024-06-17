# dotfiles

Approach explained in
[The best way to store your dotfiles: A bare Git repository](https://www.atlassian.com/git/tutorials/dotfiles).

# Smart caps lock
[Guide](https://gist.github.com/tanyuan/55bca522bf50363ae4573d4bdcf06e2e?permalink_comment_id=4271644) to map caps lock to escape and control for any OS.

# Fonts
## How to set up Nerd Fonts
[Nerd Fonts](https://www.nerdfonts.com/font-downloads) are fonts that have been extended (patched) with icons that can be displayed inside terminal emulators. The main reason I use them is for AstroNvim.

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
## OSX
### Nix commands not found after OS update
TL;DR: Append the following to `/etc/zshrc`:
```bash
# Nix
if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
  . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
fi
# End Nix
```

Source: https://github.com/NixOS/nix/issues/3616

Every OS upgrade on OSX wipes the system-wide `zshrc` file (`/etc/zshrc`) which removes the line that sources `nix-daemon.sh` which adds `~/.nix-profile/bin` to your `PATH`. So all nix commands are still there, they're just not in the `PATH`.

Is there a way around this? Can I source the nix daemon in my user-specific `.zshrc` and use that instead (effectively ignoring the system-wide one)?

## Linux

### Pop!\_OS
#### Remove window title bars
Open the Extensions application via the launcher, go to the Pop Shell settings, and toggle "Show window titles" off ([source](https://www.reddit.com/r/pop_os/comments/g79rxx/remove_title_bar_in_2004/)).

#### Could not find 'openssl'
I first encountered this problem on PopOS while trying to install the [sccache rust crate](https://github.com/mozilla/sccache) via `cargo install sccache`. But I assume it could could happen with other packages that depend on `openssl`.

Solution: `sudo apt install libssl-dev` ([source](https://github.com/mozilla/sccache))

<details>
  <summary>Full error log here</summary>
  
  ```
  error: failed to run custom build command for `openssl-sys v0.9.83`

Caused by:
  process didn't exit successfully: `/tmp/cargo-installm4v4Eo/release/build/openssl-sys-2fa74a48d50530a0/build-script-main` (exit status: 101)
  --- stdout
  cargo:rustc-cfg=const_fn
  cargo:rerun-if-env-changed=X86_64_UNKNOWN_LINUX_GNU_OPENSSL_LIB_DIR
  X86_64_UNKNOWN_LINUX_GNU_OPENSSL_LIB_DIR unset
  cargo:rerun-if-env-changed=OPENSSL_LIB_DIR
  OPENSSL_LIB_DIR unset
  cargo:rerun-if-env-changed=X86_64_UNKNOWN_LINUX_GNU_OPENSSL_INCLUDE_DIR
  X86_64_UNKNOWN_LINUX_GNU_OPENSSL_INCLUDE_DIR unset
  cargo:rerun-if-env-changed=OPENSSL_INCLUDE_DIR
  OPENSSL_INCLUDE_DIR unset
  cargo:rerun-if-env-changed=X86_64_UNKNOWN_LINUX_GNU_OPENSSL_DIR
  X86_64_UNKNOWN_LINUX_GNU_OPENSSL_DIR unset
  cargo:rerun-if-env-changed=OPENSSL_DIR
  OPENSSL_DIR unset
  cargo:rerun-if-env-changed=OPENSSL_NO_PKG_CONFIG
  cargo:rerun-if-env-changed=PKG_CONFIG_x86_64-unknown-linux-gnu
  cargo:rerun-if-env-changed=PKG_CONFIG_x86_64_unknown_linux_gnu
  cargo:rerun-if-env-changed=HOST_PKG_CONFIG
  cargo:rerun-if-env-changed=PKG_CONFIG
  cargo:rerun-if-env-changed=OPENSSL_STATIC
  cargo:rerun-if-env-changed=OPENSSL_DYNAMIC
  cargo:rerun-if-env-changed=PKG_CONFIG_ALL_STATIC
  cargo:rerun-if-env-changed=PKG_CONFIG_ALL_DYNAMIC
  cargo:rerun-if-env-changed=PKG_CONFIG_PATH_x86_64-unknown-linux-gnu
  cargo:rerun-if-env-changed=PKG_CONFIG_PATH_x86_64_unknown_linux_gnu
  cargo:rerun-if-env-changed=HOST_PKG_CONFIG_PATH
  cargo:rerun-if-env-changed=PKG_CONFIG_PATH
  cargo:rerun-if-env-changed=PKG_CONFIG_LIBDIR_x86_64-unknown-linux-gnu
  cargo:rerun-if-env-changed=PKG_CONFIG_LIBDIR_x86_64_unknown_linux_gnu
  cargo:rerun-if-env-changed=HOST_PKG_CONFIG_LIBDIR
  cargo:rerun-if-env-changed=PKG_CONFIG_LIBDIR
  cargo:rerun-if-env-changed=PKG_CONFIG_SYSROOT_DIR_x86_64-unknown-linux-gnu
  cargo:rerun-if-env-changed=PKG_CONFIG_SYSROOT_DIR_x86_64_unknown_linux_gnu
  cargo:rerun-if-env-changed=HOST_PKG_CONFIG_SYSROOT_DIR
  cargo:rerun-if-env-changed=PKG_CONFIG_SYSROOT_DIR
  run pkg_config fail: `PKG_CONFIG_ALLOW_SYSTEM_CFLAGS="1" "pkg-config" "--libs" "--cflags" "openssl"` did not exit successfully: exit status: 1
  error: could not find system library 'openssl' required by the 'openssl-sys' crate

  --- stderr
  Package openssl was not found in the pkg-config search path.
  Perhaps you should add the directory containing `openssl.pc'
  to the PKG_CONFIG_PATH environment variable
  No package 'openssl' found


  --- stderr
  thread 'main' panicked at '

  Could not find directory of OpenSSL installation, and this `-sys` crate cannot
  proceed without this knowledge. If OpenSSL is installed and this crate had
  trouble finding it,  you can set the `OPENSSL_DIR` environment variable for the
  compilation process.

  Make sure you also have the development packages of openssl installed.
  For example, `libssl-dev` on Ubuntu or `openssl-devel` on Fedora.

  If you're in a situation where you think the directory *should* be found
  automatically, please open a bug at https://github.com/sfackler/rust-openssl
  and include information about your system as well as this message.

  $HOST = x86_64-unknown-linux-gnu
  $TARGET = x86_64-unknown-linux-gnu
  openssl-sys = 0.9.83

  ', /home/alex/.cargo/registry/src/github.com-1ecc6299db9ec823/openssl-sys-0.9.83/build/find_normal.rs:190:5
  note: run with `RUST_BACKTRACE=1` environment variable to display a backtrace
warning: build failed, waiting for other jobs to finish...
error: failed to compile `sccache v0.4.0`, intermediate artifacts can be found at `/tmp/cargo-installm4v4Eo`
  ```
  
</details>

Notes:
- `openssl` seems to be installed on the system by default, so I don't know what cargo can't find exactly:
  ```bash
  $ which openssl
  /usr/bin/openssl
  ```
- There is no nix package for `libssl-dev` at the time of writing, that's why I installed it with the distro package manager. Plus, this is likely a distro-specific issue anyway, so I wouldn't wanna contaminate `home.nix` with that package.

#### Alacritty Error creating GL context
I encountered this while installing [alacritty](https://github.com/alacritty/alacritty/tree/master) on Pop!\_OS using Nix (home-manager). When I try to run `alacritty` I get the following error:

```
Error: Error creating GL context; Received multiple errors:
	Could not create EGL display object
	`glXQueryExtensionsString` found no glX extensions

Error: "Event loop terminated with code: 1"
```

##### Solution 1 (tested)
Install alacritty using the distro package manager: `sudo apt install alacritty`

The solution suggests that this is a problem with the Nix package for alacritty on non-NixOS distros.

##### Solution 2 (not tested)
This is a [known issue](https://github.com/NixOS/nixpkgs/issues/122671) on non-NixOS platforms and there is a GL wrapper for Nix called [nixGL](https://github.com/NixOS/nixpkgs/issues/122671) that [solves](https://github.com/NixOS/nixpkgs/issues/122671#issuecomment-1049355204) the problem.

However, this solution involves installing the nixGL package from a specific nix channel and then using it in front of any nix packages that have the GL issue:
```bash
# install nixGL
nix-channel --add https://github.com/guibou/nixGL/archive/main.tar.gz nixgl && nix-channel --update
nix-env -iA nixgl.auto.nixGLDefault   # or replace `nixGLDefault` with your desired wrapper

# run alacritty through nixGL
nixGL alacritty
```

I don't like either of these steps. At the very least I want to be able to install nixGL via home manager so I don't rely on this documentation every time I do this setup on a new machine. Installing alacritty via the distro package manager until this problem is officially fixed seems easier to do.

#### sudo: [command]: command not found
I encountered this error when running `sudo vim`, but I assume it can happen with any command. The problem seems to be that `sudo` is sometimes configured to (1) reset the environment and (2) only look through a set of "secure" directories for programs (as opposed to looking through the `PATH`. I don't have a source for this explanation, or the solution below, because ChatGPT gave me the answer, but it's a pretty simple fix:

Open the `sudo` config file `/etc/sudoers.tmp` using:
```
sudo visudo
```

Delete the lines that start with `Defaults env_reset` and `Defaults secure_path="..."`. Presumably the `env_reset` line resets environment variables (including `PATH`?) and `secure_path` specifies the list of directories to look through. I don't have examples of these lines because I've already removed them from my `sudoers` file and don't know how to reset it.

#### Boot menu doesn't appear
When restarting my PC, I want to be presented with a menu that show all my options os OS's I can boot into. This didn't show up by default after installing Pop!\_OS so I had to manually edit the boot settings in the BIOS each time.

The intuitive summary of the solution is: Pop!\_OS uses `systemd-boot` instead of GRUB (I think Ubuntu uses GRUB and it shows a boot menu by default), but `systemd-boot` also has a boot menu. I just had to increase the timeout so it wouldn't flash quickly and disappear, and also add an entry for Windows in the list of OS's it was aware of. Here are the specific steps:
1. Edit the `systemd-boot` boot loader config to increase the timeout:
	1. `sudo vim /boot/efi/loader/loader.conf`
	2. Find the line that starts with `timeout` (you can add it if it doesn't exist)
	3. Increase the number right after `timeout` (I set it to `timeout 10` which means 10 seconds)
	4. Testing: Reboot and check that you can now see the boot menu
2. Check that the following file exists: `/boot/efi/EFI/Microsoft/Boot/bootmgfw.efi` (in my case, the entire `Microsoft/` directory was missing) - if the file exists, proceed to step 4
3. If the file doesn't exist (and likely the entire `Microsoft/` directory) that means it's mounted onto a different partition on your hard disk than the partition that Pop!\_OS (and therefore the `systemd-boot` boot loader) is mounted on. So follow these hacky steps to copy it over:
	1. Find the partition that Windows is mounted on using `lsblk` (in my case, Windows was mounted on the first partition, `nvme0n1p1` - if this isn't clear, it's easy to verify by mounting the partition and inspecting the files inside it, as we do in the following steps):
	```
	$ lsblk -f
	NAME          FSTYPE FSVER LABEL     UUID                                 FSAVAIL FSUSE% MOUNTPOINTS
	sda
	sdb
	zram0                                                                                    [SWAP]
	nvme0n1
	├─nvme0n1p1   vfat   FAT32           F44A-C48C
	├─nvme0n1p2
	├─nvme0n1p3   ntfs                   ECB44B80B44B4C70
	├─nvme0n1p4   ntfs                   D2D6AAD9D6AABCDB
	├─nvme0n1p5   vfat   FAT32 BOOT      86E7-0FB4                             695.5M    30% /boot/efi
	├─nvme0n1p6   swap   1     swao      1feeb445-1442-481a-896b-3a23131db44c
	│ └─cryptswap swap   1     cryptswap 81382ea2-1d40-4db8-9540-4a874d69d7e4                [SWAP]
	└─nvme0n1p7   ext4   1.0   root      106660f6-f54c-451b-bbdb-7818f76e8c43  116.9G    32% /
	```
	2. Temporarily mount the partition onto a directory in your current partition and check the `Microsoft/` directory is in there:
	```
	$ sudo mount dev/nvme0n1p1 /mnt
	$ sudo ls /mnt/EFI/Microsoft
	Boot Recovery
	```
	3. Copy the `Microsoft/` directory to where `systemd-boot` seems to store its EFI stuff (I don't really understand the details):
	`$ sudo cp -f /mnt/EFI/Microsoft /boot/efi/EFI/`
	4. (Cleanup) Unmount the Windows EFI partition (for me this happens automatically on reboot, but idk): `sudo unmount /mnt`
4. Create a new entry for Windows so the boot loader can find it and show it in the boot menu:
	```
	$ sudo vim /boot/efi/loader/entries/windows.conf
	title Windows
	efi /boot/efi/EFI/Microsoft/Boot/bootmgfw.efi
	```
5. Reboot and check if there's an entry for Windows in the boot menu and if selecting it indeed boots you into Windows.
