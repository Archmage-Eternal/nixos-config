{...}: {
  flake.homeModuels.hyprland.wayland.windowManager.hyprland.settings = {
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
    };
  };
}
