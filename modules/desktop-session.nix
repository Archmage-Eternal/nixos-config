{
  lib,
  config,
  pkgs,
  ...
}: {
  flake.nixosModules.desktopSession = {
    options.meta.desktop.defaultSession = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Default tuigreet session command for desktop hosts.";
    };

    config = lib.mkIf (config.meta.desktop.defaultSession != null) {
      services.greetd = {
        enable = true;
        settings.default_session = {
          user = config.meta.username;
          command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd ${config.meta.desktop.defaultSession}";
        };
      };

      services.displayManager.autoLogin = {
        enable = true;
        user = config.meta.username;
      };
    };
  };
}