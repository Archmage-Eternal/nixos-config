# Discord via nixcord (home-manager): Equibop only, no plugins yet.
# Contributes a launch command to the keybind registry; does not know or care
# which key launches it.
{inputs, ...}: {
  flake.modules.homeManager.discord = {
    imports = [inputs.nixcord.homeModules.nixcord];

    programs.nixcord = {
      enable = true;
      # Discord is enabled by default; Equibop replaces it.
      discord.enable = false;
      equibop.enable = true;
    };

    keybinds.apps.discord = "equibop";
  };
}
