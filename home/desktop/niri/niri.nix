{
  lib,
  pkgs,
  ...
}: {
  programs.niri = {
    settings = {
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
          # refresh = 300.009;
          refresh = 60.005;
        };
        variable-refresh-rate = true;
      };

      screenshot-path = "~/Pictures/Screenshots/";
      hotkey-overlay.skip-at-startup = true;
      prefer-no-csd = false;
    };
  };
}
