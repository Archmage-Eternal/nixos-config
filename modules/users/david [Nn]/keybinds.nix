# The actual mod+key -> action list for `david`. One file, this user's data.
{
  flake.modules.homeManager.david.keybinds.actions = {
    "SUPER, Return" = {app = "terminal";};
    "SUPER, B" = {app = "browser";};

    # Focus — vim hjkl
    "SUPER, H" = {
      action = "focusDirection";
      dir = "l";
    };
    "SUPER, J" = {
      action = "focusDirection";
      dir = "d";
    };
    "SUPER, K" = {
      action = "focusDirection";
      dir = "u";
    };
    "SUPER, L" = {
      action = "focusDirection";
      dir = "r";
    };

    # Move windows
    "SUPER SHIFT, H" = {
      action = "moveWindowDirection";
      dir = "l";
    };
    "SUPER SHIFT, J" = {
      action = "moveWindowDirection";
      dir = "d";
    };
    "SUPER SHIFT, K" = {
      action = "moveWindowDirection";
      dir = "u";
    };
    "SUPER SHIFT, L" = {
      action = "moveWindowDirection";
      dir = "r";
    };

    # Workspaces
    "SUPER CTRL, K" = {
      action = "workspaceRelative";
      delta = -1;
    };
    "SUPER CTRL, J" = {
      action = "workspaceRelative";
      delta = 1;
    };
    "SUPER CTRL SHIFT, K" = {
      action = "moveToWorkspaceRelative";
      delta = -1;
    };
    "SUPER CTRL SHIFT, J" = {
      action = "moveToWorkspaceRelative";
      delta = 1;
    };

    # Window state
    "SUPER, M" = {action = "toggleFullscreen";};
    "SUPER, F" = {action = "toggleFloating";};
  };
}
