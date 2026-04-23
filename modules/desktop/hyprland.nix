{...}: {
  flake = {
    nixosModules.hyprland = {inputs, ...}: {
      imports = [inputs.hyprland.nixosModules.default];

      programs.hyprland = {
        enable = true;
        withUWSM = true;
      };

      home-manager.sharedModules = [
        inputs.hyprland.homeManagerModules.default
        inputs.self.homeModules.hyprland
      ];
    };

    homeModules.hyprland = {pkgs, ...}: {
      wayland.windowManager.hyprland = {
        enable = true;

        settings = {
          general = {
            gaps_in = 5;
            gaps_out = 10;
            border_size = 2;
            layout = "dwindle";
          };

          input = {
            kb_layout = "us";
            follow_mouse = 1;
            touchpad = {
              natural_scroll = true;
              disable_while_typing = true;
            };
          };

          dwindle = {
            pseudotile = true;
            preserve_split = true;
          };

          bind = [
            # Session
            "SUPER SHIFT, Q, exit"
            "SUPER, Q, killactive"

            # Focus — Vim hjkl
            "SUPER, H, movefocus, l"
            "SUPER, J, movefocus, d"
            "SUPER, K, movefocus, u"
            "SUPER, L, movefocus, r"

            # Move windows
            "SUPER SHIFT, H, movewindow, l"
            "SUPER SHIFT, J, movewindow, d"
            "SUPER SHIFT, K, movewindow, u"
            "SUPER SHIFT, L, movewindow, r"

            # Workspaces
            "SUPER CTRL, K, workspace, -1"
            "SUPER CTRL, J, workspace, +1"
            "SUPER CTRL SHIFT, K, movetoworkspace, -1"
            "SUPER CTRL SHIFT, J, movetoworkspace, +1"

            # Window state
            "SUPER, M, fullscreen, 1"
            "SUPER, F, togglefloating"
            "SUPER, Space, fullscreen, 0"
            "SUPER ALT, Space, fullscreen, 1"
            "SUPER, W, togglesplit"

            # Launchers
            "SUPER, Return, exec, ghostty"
            "SUPER, B, exec, zen-twilight"
            "SUPER, D, exec, dms ipc call spotlight toggle"

            # Volume
            ", XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
            ", XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
            ", XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"

            # Media
            ", XF86AudioPrev, exec, playerctl previous"
            ", XF86AudioPlay, exec, playerctl play-pause"
            ", XF86AudioNext, exec, playerctl next"

            # Screenshots
            ", Print, exec, grimblast --notify copy area"
            "CTRL, Print, exec, grimblast --notify save active"
          ];

          # Mouse binds
          bindm = [
            "SUPER, mouse:272, movewindow"
            "SUPER, mouse:273, resizewindow"
          ];
        };
      };
    };
  };
}
