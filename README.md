# Personal configuration for nixOS.

> [!WARNING]
> NOT PLUG-AND-PLAY

> [!NOTE]
> Command for building — nixos-rebuild build --flake .#hostName

```
nixos
├── hosts
│   ├── (hostName)
│   │   ├── parts
│   │   │   ├── 00-hardware.nix
│   │   │   ├── 01-disko.nix
│   │   │   ├── 02-boot.nix
│   │   │   ├── 03-locale.nix
│   │   │   ├── 10-network.nix
│   │   │   ├── 11-graphics.nix
│   │   │   ├── 12-audio.nix
│   │   │   ├── 20-programs.nix
│   │   │   ├── 21-desktop.nix
│   │   │   └── ...
│   │   ├── configuration.nix
│   │   └── overlay.nix
│   └── common.nix
│
├── modules
│   ├── desktop
│   │   └── ...
│   ├── drivers
│   │   └── ...
│   ├── editors
│   │   └── ...
│   ├── programs
│   │   └── ...
│   ├── services
│   │   └── ...
│   ├── tools
│   │   └── ...
│   └── modulesInit.nix
│
├── secrets
│   ├── (hostName)
│   │   ├── manifest.nix
│   │   └── secrets.yaml
│   └── secretsInit.nix
│
├── themes
│   ├── (themeName)
│   │   ├── theme.nix
│   │   └── ...
│   └── themesInit.nix
├── flake.nix
├── flake.lock
└── .sops.yaml
```
