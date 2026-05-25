{...}: {
  flake = {
    nixosModules.hyprland = {
      inputs,
      pkgs,
      ...
    }: {
      imports = [inputs.hyprland.nixosModules.default];

      xdg.portal.config.hyprland = {
        default = [
          "hyprland"
          "gtk"
        ];
        "org.freedesktop.impl.portal.FileChooser" = ["gtk"];
      };

      programs.hyprland = {
        enable = true;
        withUWSM = true;
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      };

      # What does this bit do?
      home-manager.sharedModules = [
        inputs.self.homeModules.hyprland
      ];
    };

    homeModules.hyprland = {
      config,
      lib,
      pkgs,
      ...
    }: {
      home.packages = with pkgs; [
        # scripts may be broken
        (pkgs.writeShellScriptBin "hypr-screenshot" (builtins.readFile ../../scripts/hypr-screenshot.sh))
        (pkgs.writeShellScriptBin "hypr-record" (builtins.readFile ../../scripts/hypr-record.sh))
        # Do we need both grim and grimblast?
        grim
        grimblast
        hypridle
        hyprlock
        # Use services.hyprpolkitagent.enable
        hyprpolkitagent
        slurp
        wf-recorder
        wl-clipboard
      ];

      # Use home-manager module for configuration
      xdg.configFile."hypr/hypridle.conf".text = ''
        general {
            lock_cmd = pidof hyprlock || hyprlock
            before_sleep_cmd = loginctl lock-session
            after_sleep_cmd = hyprctl dispatch dpms on
        }

        listener {
            timeout = 300
            on-timeout = loginctl lock-session
        }

        listener {
            timeout = 330
            on-timeout = hyprctl dispatch dpms off
            on-resume = hyprctl dispatch dpms on
        }
      '';

      # Use home-manager module for configuration
      xdg.configFile."hypr/hyprlock.conf".text = ''
        general {
            hide_cursor = true
        }

        background {
            monitor =
            path = screenshot
            blur_passes = 3
            blur_size = 8
            noise = 0.0117
            contrast = 0.8916
            brightness = 0.8172
        }

        input-field {
            monitor =
            size = 280, 56
            outline_thickness = 2
            dots_size = 0.2
            dots_spacing = 0.2
            dots_center = true
            outer_color = rgb(125, 211, 252)
            inner_color = rgb(15, 23, 42)
            font_color = rgb(241, 245, 249)
            fade_on_empty = false
            placeholder_text = <i>Password...</i>
            position = 0, -20
            halign = center
            valign = center
        }

        label {
            monitor =
            text = cmd[update:1000] echo "$TIME"
            color = rgb(241, 245, 249)
            font_size = 72
            position = 0, 90
            halign = center
            valign = center
        }

        label {
            monitor =
            text = $LAYOUT
            color = rgb(148, 163, 184)
            font_size = 18
            position = 0, 35
            halign = center
            valign = center
        }
      '';

      systemd.user.services.hypridle = {
        Unit = {
          Description = "Hyprland idle daemon";
          After = ["graphical-session.target"];
          PartOf = ["graphical-session.target"];
        };
        Service = {
          ExecStart = lib.getExe pkgs.hypridle;
          Restart = "on-failure";
        };
        Install.WantedBy = ["graphical-session.target"];
      };

      # Use services.hyprpolkitagent.enable
      systemd.user.services.hyprpolkitagent = {
        Unit = {
          Description = "Hyprland polkit agent";
          After = ["graphical-session.target"];
          PartOf = ["graphical-session.target"];
        };
        Service = {
          ExecStart = lib.getExe pkgs.hyprpolkitagent;
          Restart = "on-failure";
        };
        Install.WantedBy = ["graphical-session.target"];
      };

      wayland.windowManager.hyprland = {
        enable = true;
        package = null;
        portalPackage = null;
        settings = {
          general = {
            border_size = 1;
            gaps_in = 4;
            gaps_out = 4;
            layout = "scrolling";
          };

          input = {
            kb_layout = "us";
            follow_mouse = 1;
            repeat_rate = 25;
            repeat_delay = 600;
            sensitivity = 0.0;
            touchpad = {
              natural_scroll = true;
              disable_while_typing = true;
              middle_button_emulation = true;
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

          # Also split other components, so that this file is exclusively for hyprland configuration
          # Split binds into separate file for easier readability
          "$mod" = "SUPER";

          bind = [
            # Session
            "$mod SHIFT, Q, exec, uwsm stop"
            "$mod, Q, killactive"
            # I can't use ESC for some reason
            "$mod CTRL, L, exec, loginctl lock-session"

            # Focus — Vim hjkl
            "$mod, H, movefocus, l"
            "$mod, J, movefocus, d"
            "$mod, K, movefocus, u"
            "$mod, L, movefocus, r"

            # Move windows
            "$mod SHIFT, H, movewindow, l"
            "$mod SHIFT, J, movewindow, d"
            "$mod SHIFT, K, movewindow, u"
            "$mod SHIFT, L, movewindow, r"

            # Workspaces
            "$mod CTRL, K, workspace, -1"
            "$mod CTRL, J, workspace, +1"
            "$mod CTRL SHIFT, K, movetoworkspace, -1"
            "$mod CTRL SHIFT, J, movetoworkspace, +1"

            # Window state
            "$mod, M, fullscreen, 1"
            "$mod, F, togglefloating"
            "$mod, Space, fullscreen, 0"
            "$mod ALT, Space, fullscreen, 1"
            "$mod, W, layoutmsg, colresize +conf"
            "$mod ALT, H, layoutmsg, consume_or_expel prev"
            "$mod ALT, L, layoutmsg, consume_or_expel next"

            # Launchers
            "$mod, Return, exec, ${lib.escapeShellArgs config.desktop.launchers.terminal}"
            "$mod, B, exec, ${lib.escapeShellArgs config.desktop.launchers.browser}"
            "$mod, D, exec, ${lib.escapeShellArgs config.desktop.launchers.appLauncher}"

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
            "$mod, Print, exec, hypr-record toggle-area"
            "$mod SHIFT, Print, exec, hypr-record toggle-screen"
            "$mod CTRL, Print, exec, hypr-record stop"
          ];

          # Mouse binds
          bindm = [
            "$mod, mouse:272, movewindow"
            "$mod, mouse:273, resizewindow"
          ];
        };
      };
    };
  };
}
