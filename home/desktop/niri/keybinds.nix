{config, ...}: {
  programs.niri.settings.binds = with config.lib.niri.actions; {
    # Meta actions
    "Mod+Shift+Q".action.quit.skip-confirmation = true;
    "Mod+Q".action = close-window;

    # Navigation (focus) - Vim-like hjkl
    "Mod+H".action = focus-column-left;
    "Mod+J".action = focus-window-down;
    "Mod+K".action = focus-window-up;
    "Mod+L".action = focus-column-right;

    # Movement (move/swap windows)
    "Mod+Shift+H".action = swap-window-left;
    "Mod+Shift+J".action = move-window-down;
    "Mod+Shift+K".action = move-window-up;
    "Mod+Shift+L".action = move-column-right;

    # Workspace management
    "Mod+Ctrl+K".action = focus-workspace-up;
    "Mod+Ctrl+J".action = focus-workspace-down;

    # Move column to workspace (and focus it)
    "Mod+Ctrl+Shift+K".action.move-column-to-workspace-up.focus = true;
    "Mod+Ctrl+Shift+J".action.move-column-to-workspace-down.focus = true;

    # # Column width presets and maximize
    # "Mod+W".action = switch-preset-column-width "next";
    # "Mod+M".action = maximize-column;
    #
    # # Consume/expel windows between columns
    # "Mod+Alt+H".action = consume-or-expel-window-left;
    # "Mod+Alt+L".action = consume-or-expel-window-right;

    # Floating / tiling toggles
    "Mod+F".action = toggle-window-floating;
    "Mod+Shift+F".action = switch-focus-between-floating-and-tiling;

    # Overview and launchers
    "Mod+O".action = open-overview;
    "Mod+Return".action = spawn "ghostty"; # change to your preferred terminal
    # "Mod+D".action = spawn "dms ipc call spotlight toggle"; # use dms launcher

    # Fullscreen and layout cycling
    "Mod+Space".action = toggle-windowed-fullscreen;

    # Screenshot actions - use native niri actions instead of external tools
    "Print".action.screenshot.show-pointer = false;
    "Ctrl+Print".action.screenshot-window.write-to-disk = true;
    # "Alt+Print".action = screenshot-screen;

    # Example of using spawn-sh: useful when you need shell features
    # spawn-sh takes a single string argument passed verbatim to `sh -c`.
    # Toggle screen reader (example):
    # "Mod+Alt+R".action = spawn-sh "orca --toggle";

    # Recording example (wf-recorder). Use spawn directly for simple commands.
    # "Mod+Shift+R".action = spawn "wf-recorder -f ~/Videos/recording-$(date +%s).mkv";

    # Help overlay
    "Mod+Shift+slash".action = show-hotkey-overlay;

    # Example: scratchpad toggle (you may want to script this to spawn and hide a terminal)
    # "Mod+S".action = spawn "~/.local/bin/toggle-scratchpad";
  };
}
