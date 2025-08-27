{...}: {
  programs.hyprlock = {
    enable = true;

    settings = {
      general = {
        hide_cursor = true;
        no_fade_in = false;
        disable_loading_bar = true;
        ignore_empty_input = true;
        fractional_scaling = 0;
      };
    };
  };
}
