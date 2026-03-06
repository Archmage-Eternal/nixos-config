{...}: {
  flake = {
    nixosModules.gaming = {inputs, pkgs, ...}: {
      programs = {
        steam = {
          enable = true;
          remotePlay.openFirewall = true;
          dedicatedServer.openFirewall = false;
          protontricks.enable = true;
          gamescopeSession.enable = true;
          extraCompatPackages = [pkgs.proton-ge-bin];
        };

        gamescope = {
          enable = true;
          capSysNice = true;
          args = [
            "--rt"
            "--expose-wayland"
          ];
        };

        gamemode.enable = true;
      };

    };

    homeModules.gaming = {pkgs, ...}: {
      home.packages = with pkgs; [
        # Windows compatibility
        winetricks
        wineWowPackages.waylandFull

        # Minecraft launcher
        prismlauncher

        # Memory scanners
        scanmem
        med

        # Steam achievement manager
        samrewritten
      ];

      programs.mangohud = {
        enable = true;
        enableSessionWide = false;
        settings = {};
        settingsPerApplication = {};
      };

      # home.packages = with pkgs; [
      #   (retroarch.override {
      #     cores = with libretro; [
      #       fceumm
      #       gambatte
      #       mgba
      #       snes9x
      #     ];
      #   })
      # ];
    };
  };
}