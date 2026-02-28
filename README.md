## DIRECTORY STRUCTURE ##

"/your-config-repo
├── flake.nix
├── hosts
│   └── your-hostname
│       ├── configuration.nix
│       └── hardware-configuration.nix    # Add this here
└── home
    └── your-username
        └── home.nix
"

## NIXOS ##
sudo nixos-rebuild switch --flake .#your-hostname

## HOME ##
home-manager switch --flake .#your-username
