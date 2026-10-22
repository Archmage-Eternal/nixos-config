# nixos-config
Nix config for my machines

## Bootstrap

### Hyprland Cache
Before enabling the Hyprland configuration, build the system once with Hyrpland's substituter enabled but without the Hyprland configuration. 

This allows Nix to fetch hyprland from the binary cache instead of building it locally.