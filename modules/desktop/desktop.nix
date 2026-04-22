{config, ...}: let
  username = config.meta.username;
in {
  flake = {
    nixosModules.desktop = {
      inputs,
      pkgs,
      ...
    }: {
      imports = [
        inputs.self.nixosModules.niri
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

      services.greetd = {
        enable = true;
        settings.default_session = {
          user = username;
          command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd niri-session";
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
          pkgs.xdg-desktop-portal-gnome
        ];
        config = {
          common = {
            default = ["gtk" "gnome"];
            "org.freedesktop.impl.portal.FileChooser" = ["gtk"];
          };
          niri = {
            default = ["gnome" "gtk"];
            "org.freedesktop.impl.portal.FileChooser" = ["gtk"];
          };
        };
      };

      services = {
        displayManager.autoLogin = {
          enable = true;
          user = username;
        };
        libinput.enable = true;
      };

      # Prevent getting stuck at shutdown
      systemd.settings.Manager.DefaultTimeoutStopSec = "10s";

      home-manager.sharedModules = [inputs.self.homeModules.desktop];
    };

    homeModules.desktop = {
      inputs,
      config,
      lib,
      pkgs,
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

      home.packages = with pkgs; [
        grim
        slurp
        wf-recorder
        wl-clipboard
        grimblast
      ];

      xdg.configFile."mimeapps.list".force = true;
      xdg.mimeApps = let
        defaultApps = {
          browser = ["zen-beta.desktop"];
          text = ["vim.desktop"];
          image = ["imv-dir.desktop"];
          audio = ["mpv.desktop"];
          video = ["mpv.desktop"];
          directory = ["thunar.desktop"];
          office = ["libreoffice.desktop"];
          pdf = ["zathura.desktop"];
          terminal = ["ghostty.desktop"];
          archive = ["file-roller.desktop"];
          discord = ["vesktop.desktop"];
        };
        mimeMap = {
          text = ["text/plain"];
          image = [
            "image/bmp"
            "image/gif"
            "image/jpeg"
            "image/jpg"
            "image/png"
            "image/svg+xml"
            "image/tiff"
            "image/vnd.microsoft.icon"
            "image/webp"
          ];
          audio = [
            "audio/aac"
            "audio/mpeg"
            "audio/ogg"
            "audio/opus"
            "audio/wav"
            "audio/webm"
            "audio/x-matroska"
          ];
          video = [
            "video/mp2t"
            "video/mp4"
            "video/mpeg"
            "video/ogg"
            "video/webm"
            "video/x-flv"
            "video/x-matroska"
            "video/x-msvideo"
          ];
          directory = ["inode/directory"];
          browser = [
            "text/html"
            "x-scheme-handler/about"
            "x-scheme-handler/http"
            "x-scheme-handler/https"
            "x-scheme-handler/unknown"
          ];
          office = [
            "application/vnd.oasis.opendocument.text"
            "application/vnd.oasis.opendocument.spreadsheet"
            "application/vnd.oasis.opendocument.presentation"
            "application/vnd.openxmlformats-officedocument.wordprocessingml.document"
            "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet"
            "application/vnd.openxmlformats-officedocument.presentationml.presentation"
            "application/msword"
            "application/vnd.ms-excel"
            "application/vnd.ms-powerpoint"
            "application/rtf"
          ];
          pdf = ["application/pdf"];
          terminal = ["terminal"];
          archive = [
            "application/zip"
            "application/rar"
            "application/7z"
            "application/*tar"
          ];
          discord = ["x-scheme-handler/discord"];
        };
        associations = with lib.lists;
          lib.listToAttrs (
            flatten (
              lib.mapAttrsToList (
                key: map (type: lib.attrsets.nameValuePair type defaultApps."${key}")
              )
              mimeMap
            )
          );
      in {
        enable = true;
        associations.added = associations;
        defaultApplications = associations;
      };

      home.sessionVariables = {
        WINEDLLOVERRIDES = "winemenubuilder.exe=d";
      };
    };
  };
}
