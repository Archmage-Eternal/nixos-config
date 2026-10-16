# Translates the shared keybind registry (config.keybinds.*) into Hyprland's
# Lua `bind` entries. Each entry is { _args = [ keys (mkLuaInline dispatcher) ] }
# which the HM module serializes to `hl.bind(keys, <dispatcher>)` in
# hyprland.lua. Only the dispatcher is inline Lua; keys stay a plain string.
#
# Combos in the registry are comma-style ("SUPER, K"); Lua wants plus-style
# ("SUPER + K"), so we rewrite them here — registry data is unchanged.
{lib, ...}: {
  flake.modules.homeManager.hyprland = {
    config,
    lib,
    ...
  }: let
    inherit (lib.generators) mkLuaInline;

    # "SUPER CTRL, K" -> "SUPER + CTRL + K"
    toKeys = combo: let
      parts = lib.splitString "," combo;
      mods = lib.filter (s: s != "") (lib.splitString " " (lib.head parts));
      key = lib.strings.trim (lib.concatStringsSep "," (lib.tail parts));
    in
      lib.concatStringsSep " + " (mods ++ [key]);

    # Lua string literal via long-bracket form, so embedded quotes in a
    # command can't break out. ponytail: assumes cmd has no "]]"; fine for
    # launch commands.
    luaStr = s: "[[${s}]]";

    relWs = delta:
      if delta >= 0
      then "e+${toString delta}"
      else "e${toString delta}";

    # action def -> inline Lua dispatcher expression (as a string)
    dispatcher = combo: a:
      if a.app != null
      then "hl.dsp.exec_cmd(${luaStr config.keybinds.apps.${a.app}})"
      else if a.run != null
      then "hl.dsp.exec_cmd(${luaStr a.run})"
      else if a.action == "focusDirection"
      then ''hl.dsp.focus({ direction = "${a.dir}" })''
      else if a.action == "moveWindowDirection"
      then ''hl.dsp.window.move({ direction = "${a.dir}" })''
      else if a.action == "workspaceRelative"
      then ''hl.dsp.focus({ workspace = "${relWs a.delta}" })''
      else if a.action == "workspaceGoto"
      then ''hl.dsp.focus({ workspace = "${toString a.index}" })''
      else if a.action == "moveToWorkspaceRelative"
      then ''hl.dsp.window.move({ workspace = "${relWs a.delta}" })''
      else if a.action == "moveToWorkspaceGoto"
      then ''hl.dsp.window.move({ workspace = "${toString a.index}" })''
      else if a.action == "toggleFullscreen"
      then ''hl.dsp.window.fullscreen({ action = "toggle", mode = "fullscreen" })''
      else if a.action == "toggleFloating"
      then ''hl.dsp.window.float({ action = "toggle" })''
      else throw "keybinds.actions.\"${combo}\": no translation for this action";

    toBind = combo: a: {
      _args = [
        (toKeys combo)
        (mkLuaInline (dispatcher combo a))
      ];
    };
  in {
    wayland.windowManager.hyprland.settings.bind =
      lib.mapAttrsToList toBind config.keybinds.actions;
  };
}
