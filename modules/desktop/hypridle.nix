{...}: {
  flakes.homeManagerModules.desktop.hypr.services.hypridle = {
    enable = true;
    settings = {
      general = {
        lock_cmd = "hyprlock";
        before_sleep_cmd = "loginctl lock-session";
        after_sleep_cmd = "hyprctl dispatch dpms on";
      };

      listener = [
        {
          timeout = 600;
          on_timeout = "hyprlock";
        }
        {
          timeout = 1200;
          on_timeout = "hyprctl dispatch dpms off";
          on_resume = "hyprctl dispatch dpms on";
        }
      ];
    };
  };
}
