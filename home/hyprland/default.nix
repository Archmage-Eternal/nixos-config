{ inputs, ... }:
{
  imports = [
    ./hyprland.nix
    ./config.nix
    ./hyprlock.nix
    ./aesthetics.nix
    ./animations.nix
    ./keybinds.nix
    ./windowrules.nix
    inputs.hyprland.homeManagerModules.default
  ];
}
