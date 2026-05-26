{config, ...}: let
  username = config.meta.username;
in {
  flake.nixosModules.desktopSession = {
    lib,
    config,
    pkgs,
    ...
  }: {
    options.meta.desktop.defaultSession = lib.mkOption {
      type = lib.types.nullOr lib.types.str;
      default = null;
      description = "Default tuigreet session command for desktop hosts.";
    };

    config = lib.mkIf (config.meta.desktop.defaultSession != null) {
      services.greetd = {
        enable = true;
        settings.default_session = {
          user = username;
          command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd ${config.meta.desktop.defaultSession}";
        };
      };

      services.displayManager.autoLogin = {
        enable = true;
        user = username;
      };
    };
  };
}
