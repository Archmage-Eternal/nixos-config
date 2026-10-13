# Translates the shared keybind registry (config.keybinds.*) into Hyprland's
# `bind` syntax. Pure syntax mapping — no business logic.
{lib, ...}: {
  flake.modules.homeManager.hyprland = {
    config,
    lib,
    ...
  }: let
    toBind = combo: a:
      if a.app != null
      then "${combo}, exec, ${config.keybinds.apps.${a.app}}"
      else if a.run != null
      then "${combo}, exec, ${a.run}"
      else throw "keybinds.actions.\"${combo}\": no translation yet for this action";
  in {
    wayland.windowManager.hyprland.settings.bind =
      lib.mapAttrsToList toBind config.keybinds.actions;
  };
}
