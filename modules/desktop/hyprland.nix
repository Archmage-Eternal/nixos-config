{...}: {
  flake = {
    nixosModules.hyprland = {
      inputs,
      pkgs,
      ...
    }: {
      imports = [inputs.hyprland.nixosModules.default];

      programs.hyprland = {
        enable = true;
        withUWSM = true;
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      };

      home-manager.sharedModules = [
        inputs.self.homeModules.hyprland
      ];
    };

    homeModules.hyprland = {...}: {
      wayland.windowManager.hyprland = {
        enable = true;
        package = null;
        portalPackage = null;
        settings = {
          general = {
            gaps_in = 5;
            gaps_out = 10;
            border_size = 2;
            layout = "scrolling";
          };

          input = {
            kb_layout = "us";
            follow_mouse = 1;
            touchpad = {
              natural_scroll = true;
              disable_while_typing = true;
            };
          };

          scrolling = {
            column_width = 0.5;
            focus_fit_method = 1;
            follow_focus = true;
            fullscreen_on_one_column = true;
            wrap_focus = true;
            wrap_swapcol = true;
          };

          xwayland = {
            force_zero_scaling = true;
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
            "SUPER, W, layoutmsg, colresize +conf"

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
            ", Print, exec, hypr-screenshot copy-area"
            "SHIFT, Print, exec, hypr-screenshot save-area"
            "CTRL, Print, exec, hypr-screenshot save-screen"

            # Recording
            "SUPER, Print, exec, hypr-record toggle-area"
            "SUPER SHIFT, Print, exec, hypr-record toggle-screen"
            "SUPER CTRL, Print, exec, hypr-record stop"
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
