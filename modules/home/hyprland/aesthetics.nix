{...}: {
  wayland.windowManager.hyprland = {
    settings = {
      decoration = {
        rounding = 5;
        active_opacity = 0.95;
        inactive_opacity = 0.95;
        # fullscreen_opacity = 1.0;

        blur = {
          enabled = true;
          size = 3;
          passes = 2;
          brightness = 1;
          contrast = 1.4;
          ignore_opacity = true;
          noise = 0;
          new_optimizations = true;
          xray = true;
        };

        shadow = {
          enabled = true;
          ignore_window = true;
          offset = "0 2";
          range = 20;
          render_power = 3;
          color = "rgba(00000055)";
        };
      };
    };
  };
}
