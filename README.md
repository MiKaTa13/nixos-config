# My nixOS config

## DIRECTORY STRUCTURE
```
/your-config-repo
├── home
│   └── your-username
│       ├── modules
│       │   ├── patches
│       │   │   ├── dwm
│       │   │   └── st
│       │   └── sources
│       │       ├── dmenu
│       │       ├── dwm
│       │       ├── dwmblocks
│       │       └── st
│       └── secrets
└── hosts
    └── your-hostname
        └── os_modules

```

## NIXOS
sudo nixos-rebuild switch --flake .#your-hostname
