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
        system = system;
        specialArgs = {
          inherit username;
        };
        modules = [
          ./hosts/${hostname}/configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager = {
              # Enable home-manager integration in NixOS config
              useGlobalPkgs = true;
              useUserPackages = true;
              users = {
                ${username} = import ./home/${username}/home.nix;
              };
              backupFileExtension = "backup"; # move existing files by appending the "backup".
              extraSpecialArgs = {
                inherit username agenix;
                inherit pkgs-unstable; # Allow use unstable packages in home.
                secretPath = "/nix-config/home/nix/secrets"; # Path to age encripted files.
              };
            };
          }
        ];
      };
    };
  };
}
