# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.efi.efiSysMountPoint = "/boot/efi";

  networking = {
    # Enable networking
    networkmanager.enable = true;
    hostName = "nixos"; # Define your hostname.
    # Configure network proxy if necessary
    # proxy.default = "http://user:password@proxy:port/";
    # proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  };

  services.xserver = {
    enable = true;
    windowManager.qtile.enable = true;
    displayManager = {
      lightdm = {
        enable = true;
        background = pkgs.nixos-artwork.wallpapers.dracula.gnomeFilePath;
      };
      defaultSession = "none+qtile";
      autoLogin = {
        enable = true;
        user = "alex";
      };
    };
    
    # Configure keymap in X11
    layout = "us";
    xkbVariant = "";
  };

  # Enable bluetooth
  hardware.bluetooth.enable = true;
  hardware.pulseaudio.enable = true;
  services.blueman.enable = true;

  # Enable USB automounting for pcmanfm (source: https://nixos.wiki/wiki/PCManFM)
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.devmon.enable = true;
  
  # Set your time zone.
  time.timeZone = "Europe/London";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_GB.utf8";

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.alex = {
    isNormalUser = true;
    description = "Alex Georgousis";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [];
  };

  # Allow user to install nixpkgs
  nix.allowedUsers = [ "alex" ];

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable VirtualBox
  virtualisation.virtualbox = {
    host = {
      enable = true;
      enableExtensionPack = true;
    };
    guest = {
      enable = true;
      x11 = true;
    };
  };
  users.extraGroups.vboxusers.members = [ "alex" ];

  # Automatically run garbage collection
  nix.gc = {
    automatic = true;
    dates = "daily";
    options = "--delete-older-than 3d";
  };

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
  #  vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
  #  wget
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "22.05"; # Did you read the comment?

}
