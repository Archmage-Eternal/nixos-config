{...}: {
  flake.homeModuels.hyprland.wayland.windowManager.hyprland.settings = {
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
}
