# Translates the shared keybind registry (config.keybinds.*) into MangoWM's
# `bind` entries (list of "MOD,key,dispatcher,arg" strings). Pure syntax
# mapping — no business logic.
#
# Registry combos are "SUPER CTRL, K" (space-separated mods); Mango wants
# "SUPER+CTRL,K" (plus-joined mods). We rewrite the mod portion here; registry
# data is unchanged. Mango uses tags rather than workspaces, so our workspace
# verbs map to Mango's view/tag dispatchers.
{
  flake.modules.homeManager.mangowm = {
    config,
    lib,
    ...
  }: let
    dir = {
      l = "left";
      r = "right";
      u = "up";
      d = "down";
    };

    # "SUPER CTRL, K" -> "SUPER+CTRL,K"
    toKeys = combo: let
      parts = lib.splitString "," combo;
      mods = lib.filter (s: s != "") (lib.splitString " " (lib.head parts));
      key = lib.strings.trim (lib.concatStringsSep "," (lib.tail parts));
    in "${lib.concatStringsSep "+" mods},${key}";

    # action def -> mango "dispatcher,arg" suffix
    suffix = combo: a:
      if a.app != null
      then "spawn,${config.keybinds.apps.${a.app}}"
      else if a.run != null
      then "spawn,${a.run}"
      else if a.action == "focusDirection"
      then "focusdir,${dir.${a.dir}}"
      else if a.action == "moveWindowDirection"
      then "exchange_client,${dir.${a.dir}}"
      else if a.action == "workspaceRelative"
      then
        (
          if a.delta == 1
          then "viewtoright,0"
          else if a.delta == -1
          then "viewtoleft,0"
          else throw "keybinds.actions.\"${combo}\": mango supports only delta = +/-1 for workspaceRelative"
        )
      else if a.action == "workspaceGoto"
      then "view,${toString a.index}"
      else if a.action == "moveToWorkspaceRelative"
      then
        (
          if a.delta == 1
          then "tagtoright,0"
          else if a.delta == -1
          then "tagtoleft,0"
          else throw "keybinds.actions.\"${combo}\": mango supports only delta = +/-1 for moveToWorkspaceRelative"
        )
      else if a.action == "moveToWorkspaceGoto"
      then "tag,${toString a.index}"
      else if a.action == "toggleFullscreen"
      then "togglefullscreen,"
      else if a.action == "toggleFloating"
      then "togglefloating,"
      else throw "keybinds.actions.\"${combo}\": no mango translation for this action";

    toBind = combo: a: "${toKeys combo},${suffix combo a}";
  in {
    wayland.windowManager.mango.settings.bind =
      lib.mapAttrsToList toBind config.keybinds.actions;
  };
}
