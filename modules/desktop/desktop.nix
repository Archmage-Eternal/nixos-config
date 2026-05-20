{...}: {
  flake = {
    nixosModules.desktop = {
      inputs,
      pkgs,
      ...
    }: {
      imports = [
        inputs.stylix.nixosModules.stylix
      ];

      services.dbus.implementation = "broker";

      programs = {
        dconf.enable = true;
        nix-ld = {
          enable = true;
          libraries = [];
        };
      };

      stylix = {
        enable = true;
        base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
        polarity = "dark";
        cursor = {
          package = pkgs.bibata-cursors;
          name = "Bibata-Modern-Ice";
          size = 24;
        };
        fonts = {
          sizes = {
            desktop = 12;
            applications = 15;
            terminal = 17;
            popups = 17;
          };
          monospace = {
            package = pkgs.nerd-fonts.iosevka-term;
            name = "Iosevka Term NF";
          };
          sansSerif = {
            package = pkgs.noto-fonts;
            name = "Noto Sans";
          };
          serif = {
            package = pkgs.noto-fonts;
            name = "Noto Serif";
          };
          emoji = {
            package = pkgs.noto-fonts-color-emoji;
            name = "Noto Color Emoji";
          };
        };
      };

      xdg.portal = {
        enable = true;
        extraPortals = [
          pkgs.xdg-desktop-portal-gtk
        ];
        config = {
          common = {
            default = ["gtk"];
            "org.freedesktop.impl.portal.FileChooser" = ["gtk"];
          };
        };
      };

      services = {
        libinput.enable = true;
      };

      # Prevent getting stuck at shutdown
      systemd.settings.Manager.DefaultTimeoutStopSec = "10s";

      home-manager.sharedModules = [inputs.self.homeModules.desktop];
    };

    homeModules.desktop = {
      inputs,
      config,
      ...
    }: {
      imports = [
        inputs.dankMaterialShell.homeModules.dank-material-shell
        inputs.dsearch.homeModules.default
      ];

      programs.dank-material-shell = {
        enable = true;
        systemd = {
          enable = true;
          restartIfChanged = false;
        };
        enableSystemMonitoring = true;
        enableVPN = false;
        enableDynamicTheming = false;
        enableAudioWavelength = true;
        enableCalendarEvents = true;
        settings.theme = "dark";
      };

      programs.dsearch = {
        enable = true;
        config = {};
      };

      services = {
        playerctld.enable = true;
        poweralertd = {
          enable = true;
          extraArgs = [];
        };
      };

      stylix.targets = {
        spicetify.enable = false;
        zen-browser.profileNames = ["default"];
      };

      gtk.gtk4.theme = config.gtk.theme;

      home.sessionVariables = {
        WINEDLLOVERRIDES = "winemenubuilder.exe=d";
      };
    };
  };
}
