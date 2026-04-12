{
  description = "Unified NixOS and Home Manager configuration";

  inputs = {
    # Nix-system
    nixpkgs.url = "github:nixos/nixpkgs/25.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home-manager
    home-manager.url = "github:nix-community/home-manager/release-25.11";
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
        inherit system;
        specialArgs = {
          inherit username;
        };
        modules = [
          ./hosts/${hostname}/configuration.nix
          home-manager.nixosModules.home-manager
          agenix.nixosModules.default
          {
            home-manager = {
              users = {
                ${username} = import ./home/${username}/home.nix;
              };
              # Enable home-manager integration in NixOS config
              useGlobalPkgs = true;
              useUserPackages = true;

              extraSpecialArgs = {
                inherit username agenix pkgs-unstable;
                secretPath = "/nix-config/home/${username}/secrets"; # Path to age encripted files.
              };
            };
          }
        ];
      };
    };
  };
}
