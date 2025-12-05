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

      screenshot-path = "~/Pictures/Screenshots/";
      hotkey-overlay.skip-at-startup = true;
      prefer-no-csd = false;
    };
  };
}
