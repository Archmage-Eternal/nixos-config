# User `david` — Home-Manager bundle. Imports grow as features are added.
{inputs, ...}: {
  flake.modules.homeManager.david = {
    # User identity lives with the HM module so it's self-contained and
    # reusable standalone (homeConfigurations) on non-NixOS Nix machines.
    home.username = "david";
    home.homeDirectory = "/home/david";
    home.stateVersion = "26.11";
    imports = with inputs.self.modules.homeManager; [
      keybinds
      terminal
      browser
      hyprland
      mangowm
    ];
  };
}
