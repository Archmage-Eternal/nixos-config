# User `david` — Home-Manager bundle. Imports grow as features are added.
{inputs, ...}: {
  flake.modules.homeManager.david = {
    imports = with inputs.self.modules.homeManager; [
      keybinds
      terminal
      browser
      hyprland
      mangowm
    ];
  };
}
