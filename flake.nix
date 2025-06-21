{
  description = "My NixOS system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.05";
  };

  outputs = { self, nixpkgs }: {
    nixosConfigurations.alex = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./.config/nixos/configuration.nix
        ./.config/nixos/hardware-configuration.nix
      ];
    };
  };
}

