# NixOS

# Reasons for leaving NixOS

I'm considering abandoning NixOS (and therefore nix/home-manager in general because my experience of trying to use those in Ubuntu wasn't good). Honestly, it's just a bit too inonvenient to use.

## Flakes syntax is confusing

I've set it up but I don't understand it, it all seems very arcane. So when something breaks... 🤷‍♂️.

## NixOS cannot run a lot of linux programs installed via a standard non-nix way

Examples include language servers for Neovim installed automatically by Mason or programs installed using `asdf`. This happens because a lot of of those binaries are linked dymanically and expect certain low level libraries to exist at certain standard locations. NixOS doesn't support the Filesystem Hierarchy Standard (FHS) which means it can't guarantee that those standard directories exist. 

The easiest solution is to simply install everything via Nix, but that doesn't work in practice. For example, nixpkgs doesn't have all versions of all programs like languages or programming tools like `minikube`. So if I want to, for example, fix the version of a tool in the `.tool-versions` file of a project, I can't do that because NixOS won't be able to run whatever asdf installs.

## There is an alternative

The main reasons I started using Nix and eventually NixOS are:
- The ability to create a setup that is easily reproducible across machines or when wiping a machine.
- Having everything in configuration files in a repo allows me to build my setup like a normal github project (organise it how I want etc.)
- Having everything in config files allows me to add documentation for everything where it is defined, so I never have to wonder "why did I do that again..." or "where did that package or piece of config come from?".
- Basically: I want every part of my setup to explicitly defined. If it's not in config then it doesn't exist.

But Nix isn't the only way to achieve this. I believe I can do it manually with relative ease, via scripts. So the setup would be:
- Whenever configuration files are available, great! Use them.
- When they're not, and something is only possible to do imperatively (e.g. installing packages or enabling `systemd` services), then I can create a script that does it and add it to my dotfiles.
- This way, on a new system, I just run 1 install script to bootstrap everything.
