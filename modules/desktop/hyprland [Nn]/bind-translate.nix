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
      else if a.action == "focusDirection"
      then "${combo}, movefocus, ${a.dir}"
      else if a.action == "moveWindowDirection"
      then "${combo}, movewindow, ${a.dir}"
      else if a.action == "workspaceRelative"
      then "${combo}, workspace, ${
        if a.delta >= 0
        then "+${toString a.delta}"
        else toString a.delta
      }"
      else if a.action == "workspaceGoto"
      then "${combo}, workspace, ${toString a.index}"
      else if a.action == "moveToWorkspaceRelative"
      then "${combo}, movetoworkspace, ${
        if a.delta >= 0
        then "+${toString a.delta}"
        else toString a.delta
      }"
      else if a.action == "moveToWorkspaceGoto"
      then "${combo}, movetoworkspace, ${toString a.index}"
      else if a.action == "toggleFullscreen"
      then "${combo}, fullscreen"
      else if a.action == "toggleFloating"
      then "${combo}, togglefloating"
      else throw "keybinds.actions.\"${combo}\": no translation yet for this action";
  in {
    wayland.windowManager.hyprland.settings.bind =
      lib.mapAttrsToList toBind config.keybinds.actions;
  };
}
