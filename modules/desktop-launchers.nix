{...}: {
  flake = {
    nixosModules.desktopLaunchers = {
      inputs,
      lib,
      config,
      ...
    }: {
      options.meta.desktop.launchers = {
        terminal = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = ["ghostty"];
          description = "Command used by desktop keybinds to launch the terminal.";
        };

        browser = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = ["zen-twilight"];
          description = "Command used by desktop keybinds to launch the browser.";
        };

        appLauncher = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          default = [
            "dms"
            "ipc"
            "call"
            "spotlight"
            "toggle"
          ];
          description = "Command used by desktop keybinds to open the application launcher.";
        };
      };

      config.home-manager.sharedModules = [
        inputs.self.homeModules.desktopLaunchers
        ({...}: {
          desktop.launchers = config.meta.desktop.launchers;
        })
      ];
    };

    homeModules.desktopLaunchers = {lib, ...}: {
      options.desktop.launchers = {
        terminal = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          description = "Terminal launcher command exposed to desktop compositor modules.";
        };

        browser = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          description = "Browser launcher command exposed to desktop compositor modules.";
        };

        appLauncher = lib.mkOption {
          type = lib.types.listOf lib.types.str;
          description = "Application launcher command exposed to desktop compositor modules.";
        };
      };
    };
  };
}
