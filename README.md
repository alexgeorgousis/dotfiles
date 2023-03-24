# dotfiles

Approach explained in
[The best way to store your dotfiles: A bare Git repository](https://www.atlassian.com/git/tutorials/dotfiles).

# yadm
I'm using [yadm](https://yadm.io/) to manage these dotfiles. Unfortunately there's not a nix package for it yet,
so I've installed it manually under ~/.cli/bin.

TODO: How to make a config file or directory OS-specific

TODO: How to turn a config file into a template

TODO: How to edit a template (and apply the changes)

# iTerm2
## Clear Buffer keybind

This is set to `Cmd`+`k` by default, but I wanted to map `Cmd`+`k` to "Select Split Pane Above"
(along with `Cmd`+`h` `Cmd`+`j`, `Cmd`+`l` for the other directions).
`Cmd`+`Shift`+`k` is mapped to the Clear Buffer command to still allow clearing the terminal,
however `Ctrl`+`l` is easier to press and is not MacOS specific, so it's a better alternative.

Sidenote: Unforutunately, the keybind for the Clear Buffer command can only be configured
[manually via App Shortcuts](https://superuser.com/questions/1154896/remapping-iterm-2s-shortcut-for-clear-buffer)
and not via iTerm2 config, so loading the iTerm2 configuration file is not sufficient.

## .hushlogin
By default, iTerm2 displays a "Last login" message in every new window. Apparently creating an empty `.hushlogin` file
in the home directory is the way to fix it. Strange, but it works.

### Toggling transparency
You can toggle window transparency using `Cmd` + `u` (this hotkey is set in iTerm2 by default). This can be useful
because you can set the transparency to a high value and then quickly turn it off if you move the terminal on top of
another window.

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
### Could not find 'openssl'
I first encountered this problem on PopOS while trying to install the [sccache rust crate](https://github.com/mozilla/sccache) via `cargo install sccache`.

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
