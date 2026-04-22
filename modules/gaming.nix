{...}: {
  flake = {
    nixosModules.gaming = {
      inputs,
      pkgs,
      ...
    }: {
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

      services.udev.packages = [pkgs.steam-devices-udev-rules];
    };

    homeModules.gaming = {pkgs, ...}: {
      programs.mangohud = {
        enable = true;
        enableSessionWide = false;
        settings = {};
        settingsPerApplication = {};
      };

      home.packages = with pkgs; [
        winetricks
        wineWowPackages.waylandFull
        prismlauncher
        scanmem
        med
        samrewritten
      ];
    };
  };
}
