{...}: {
  flake = {
    nixosModules.niri = {inputs, pkgs, ...}: {
      nixpkgs.overlays = [inputs.niri-flake.overlays.niri];

      imports = [inputs.niri-flake.nixosModules.niri];

      programs.niri = {
        enable = true;
        package = pkgs.niri-unstable;
      };

      home-manager.sharedModules = [inputs.self.homeModules.niri];
    };

    homeModules.niri = {
      config,
      lib,
      pkgs,
      ...
    }: {
      programs.niri.settings = {
        xwayland-satellite = {
          enable = true;
          path = lib.getExe pkgs.xwayland-satellite-unstable;
        };

        input = {
          "mod-key" = "Super";
          "mod-key-nested" = "Alt";
          touchpad = {
            enable = true;
            disabled-on-external-mouse = true;
            dwt = true;
          };
        };

        outputs."Sharp Corporation LQ156M1JW25 Unknown" = {
          mode = {
            width = 1920;
            height = 1080;
            refresh = 60.005;
          };
          variable-refresh-rate = true;
        };

        screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";
        hotkey-overlay.skip-at-startup = true;
        prefer-no-csd = false;

        binds = with config.lib.niri.actions; {
          # Meta actions
          "Mod+Shift+Q".action.quit.skip-confirmation = true;
          "Mod+Q".action = close-window;

          # Navigation (focus) - Vim-like hjkl
          "Mod+H".action = focus-column-left;
          "Mod+J".action = focus-window-down;
          "Mod+K".action = focus-window-up;
          "Mod+L".action = focus-column-right;

          # Movement (move/swap windows)
          "Mod+Shift+H".action = move-column-left;
          "Mod+Shift+J".action = move-window-down;
          "Mod+Shift+K".action = move-window-up;
          "Mod+Shift+L".action = move-column-right;

          # Workspace management
          "Mod+Ctrl+K".action = focus-workspace-up;
          "Mod+Ctrl+J".action = focus-workspace-down;

          # Move column to workspace (and focus it)
          "Mod+Ctrl+Shift+K".action.move-column-to-workspace-up.focus = true;
          "Mod+Ctrl+Shift+J".action.move-column-to-workspace-down.focus = true;

          # Column width presets and maximize
          "Mod+W".action = switch-preset-column-width;
          "Mod+M".action = maximize-column;

          # Consume/expel windows between columns
          "Mod+Alt+H".action = consume-or-expel-window-left;
          "Mod+Alt+L".action = consume-or-expel-window-right;

          # Floating / tiling toggles
          "Mod+F".action = toggle-window-floating;
          "Mod+Shift+F".action = switch-focus-between-floating-and-tiling;

          # Overview and launchers
          "Mod+O".action = toggle-overview;
          "Mod+Return".action = spawn "ghostty";
          "Mod+B".action = spawn "zen-twilight";
          "Mod+D".action = spawn "dms" "ipc" "call" "spotlight" "toggle";

          # Fullscreen and layout cycling
          "Mod+Space".action = fullscreen-window;
          "Mod+Alt+Space".action = toggle-windowed-fullscreen;

          # Volume keys
          "XF86AudioRaiseVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%+"];
          "XF86AudioLowerVolume".action.spawn = ["wpctl" "set-volume" "@DEFAULT_AUDIO_SINK@" "5%-"];
          "XF86AudioMute".action.spawn = ["wpctl" "set-mute" "@DEFAULT_AUDIO_SINK@" "toggle"];

          # Media playback keys
          "XF86AudioPrev".action.spawn = ["playerctl" "previous"];
          "XF86AudioPlay".action.spawn = ["playerctl" "play-pause"];
          "XF86AudioNext".action.spawn = ["playerctl" "next"];

          # Screenshot actions
          "Print".action.screenshot.show-pointer = false;
          "Ctrl+Print".action.screenshot-window.write-to-disk = true;

          # Help overlay
          "Mod+Shift+slash".action = show-hotkey-overlay;
        };
      };
    };
  };
}
