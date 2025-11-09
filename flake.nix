{
  description = "Unified NixOS and Home Manager configuration";

  inputs = {
    # Nix-system
    nixpkgs.url = "github:nixos/nixpkgs/25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home-manager
    home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # Agenix
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = {
    nixpkgs,
    nixpkgs-unstable,
    home-manager,
    agenix,
    ...
  }: let
    system = "x86_64-linux";
    hostname = "nixos"; # replace with your actual hostname
    username = "nix"; # replace with your actual username
    pkgs-unstable = nixpkgs-unstable.legacyPackages.${system};
  in {
    nixosConfigurations = {
      ${hostname} = nixpkgs.lib.nixosSystem {
        system = system;
        modules = [
          ./hosts/${hostname}/configuration.nix
          home-manager.nixosModules.home-manager
          {
            # Enable home-manager integration in NixOS config
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users = {
              ${username} = import ./home/${username}/home.nix;
            };
            home-manager.extraSpecialArgs = {
              inherit username agenix pkgs-unstable;
            };
          }
        ];
        specialArgs = {
          inherit username pkgs-unstable;
        };
      };
    };
  };
}
