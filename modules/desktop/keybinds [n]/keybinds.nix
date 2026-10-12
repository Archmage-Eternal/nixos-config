# Keybind registry schema (home-manager, generic data — not compositor-
# specific). Compositor modules read config.keybinds.* and translate it into
# their own bind syntax. App modules only ever add to keybinds.apps.
{
  flake.modules.homeManager.keybinds = {lib, ...}: {
    options.keybinds = {
      apps = lib.mkOption {
        type = lib.types.attrsOf lib.types.str;
        default = {};
        description = "App name -> shell command to launch it.";
      };

      actions = lib.mkOption {
        type = lib.types.attrsOf (lib.types.submodule {
          options = {
            app = lib.mkOption {
              type = lib.types.nullOr lib.types.str;
              default = null;
              description = "Name into keybinds.apps to launch.";
            };
            run = lib.mkOption {
              type = lib.types.nullOr lib.types.str;
              default = null;
              description = "Literal shell command to run.";
            };
            action = lib.mkOption {
              type = lib.types.nullOr (lib.types.enum [
                "focusDirection"
                "moveWindowDirection"
                "workspaceRelative"
                "workspaceGoto"
                "moveToWorkspaceRelative"
                "moveToWorkspaceGoto"
                "toggleFullscreen"
                "toggleFloating"
              ]);
              default = null;
            };
            dir = lib.mkOption {
              type = lib.types.nullOr (lib.types.enum ["l" "r" "u" "d"]);
              default = null;
            };
            delta = lib.mkOption {
              type = lib.types.nullOr lib.types.int;
              default = null;
            };
            index = lib.mkOption {
              type = lib.types.nullOr lib.types.int;
              default = null;
            };
          };
        });
        default = {};
        description = ''
          Mod+key combo (e.g. "SUPER, B") -> action definition. Exactly one
          of app/run/action should be set per entry.
        '';
      };
    };
  };
}
