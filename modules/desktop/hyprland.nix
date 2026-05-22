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
        (pkgs.writeShellScriptBin "hypr-screenshot" (builtins.readFile ../../scripts/hypr-screenshot.sh))
        (pkgs.writeShellScriptBin "hypr-record" (builtins.readFile ../../scripts/hypr-record.sh))
        grim
        grimblast
        hypridle
        hyprlock
        hyprpolkitagent
        slurp
        wf-recorder
        wl-clipboard
      ];

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
            "SUPER SHIFT, Q, exec, uwsm stop"
            "SUPER, Q, killactive"
            "SUPER CTRL, L, exec, loginctl lock-session"

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
            "SUPER ALT, H, layoutmsg, consume_or_expel prev"
            "SUPER ALT, L, layoutmsg, consume_or_expel next"

            # Launchers
            "SUPER, Return, exec, ${lib.escapeShellArgs config.desktop.launchers.terminal}"
            "SUPER, B, exec, ${lib.escapeShellArgs config.desktop.launchers.browser}"
            "SUPER, D, exec, ${lib.escapeShellArgs config.desktop.launchers.appLauncher}"

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
