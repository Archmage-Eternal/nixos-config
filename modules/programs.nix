{config, ...}: let
  username = config.meta.username;
in {
  flake = {
    nixosModules.programs = {
      inputs,
      pkgs,
      ...
    }: {
      programs.nh = {
        enable = true;
        clean = {
          enable = true;
          extraArgs = "--keep-since 7d --keep 5";
        };
        flake = "/home/${username}/nixos-config";
      };

      environment.systemPackages = with pkgs; [
        git
        vim
        wget
        nix-output-monitor
        nvd
      ];

      home-manager.sharedModules = [inputs.self.homeModules.programs];
    };

    homeModules.programs = {
      inputs,
      pkgs,
      ...
    }: let
      spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.hostPlatform.system};
    in {
      imports = [
        inputs.nixcord.homeModules.nixcord
        inputs.spicetify-nix.homeManagerModules.spicetify
        inputs.zen-browser.homeModules.twilight
      ];

      home.packages = with pkgs; [
        # GUI apps
        blender
        calibre
        gimp
        krita
        libreoffice
        obs-studio
        openrgb-with-all-plugins
        pwvucontrol
        qbittorrent-enhanced
        xfce.thunar
        vlc
        zotero-beta

        # CLI utilities
        aria2
        dysk
        file
        glow
        killall
        libnotify
        ncdu
        nitch
        nvtopPackages.full
        onefetch
        p7zip
        unrar
        shfmt
        trash-cli
        w3m
        wget
        xdg-utils
        bitwise
        ffmpeg
        mimeo
        ani-cli
        swappy
        tdf
        nb
        cbonsai
        cmatrix
        pipes
        tty-clock
        caligula
        dualsensectl
        wavemon
        poweralertd
        playerctl

        # Scripts
        (pkgs.writeShellScriptBin "protonhax" (builtins.readFile ../scripts/protonhax.sh))
        (pkgs.writeShellScriptBin "j" (builtins.readFile ../scripts/journal.sh))
        (pkgs.writeShellScriptBin "z" (builtins.readFile ../scripts/zettelkasten.sh))
        (pkgs.writeShellScriptBin "li" (builtins.readFile ../scripts/lists.sh))
      ];

      programs = {
        atuin = {
          enable = true;
          enableBashIntegration = true;
          enableZshIntegration = true;
        };

        bat = {
          enable = true;
          config.pager = "less -FR";
          extraPackages = with pkgs.bat-extras; [
            batman
            batpipe
            batgrep
          ];
        };

        btop = {
          enable = true;
          settings.update_ms = 500;
        };

        cava = {
          enable = true;
          settings.general = {
            autosens = 1;
            overshoot = 0;
          };
        };

        eza = {
          enable = true;
          enableBashIntegration = true;
          git = false;
          extraOptions = [];
        };

        fastfetch.enable = true;

        fd = {
          enable = true;
          hidden = false;
          ignores = [];
          extraOptions = [];
        };

        fzf.enable = true;

        gallery-dl = {
          enable = true;
          settings = {};
        };

        ghostty = {
          enable = true;
          settings = {
            window-decoration = false;
            keybind = [];
          };
        };

        imv = {
          enable = true;
          settings = {};
        };

        jq.enable = true;
        jqp = {
          enable = true;
          settings = {};
        };

        micro.enable = true;

        mpv = {
          enable = true;
          config = {};
          bindings = {};
        };

        nixcord = {
          enable = true;
          discord = {
            enable = false;
            vencord.enable = false;
            equicord.enable = false;
          };
          vesktop.enable = false;
          equibop.enable = true;
          dorion.enable = false;
          config = {
            frameless = true;
            plugins = {
              hideMedia.enable = true;
              ignoreActivities = {
                enable = true;
                ignorePlaying = true;
                ignoreWatching = true;
              };
            };
          };
          extraConfig = {};
        };

        ripgrep.enable = true;
        ripgrep-all.enable = true;

        spicetify = {
          enable = true;
          enabledExtensions = with spicePkgs.extensions; [
            adblockify
            keyboardShortcut
            savePlaylists
            shuffle
          ];
          theme = spicePkgs.themes.text;
        };

        tealdeer = {
          enable = true;
          settings = {
            display = {
              compact = false;
              use_pager = true;
              updates.auto_update = true;
            };
          };
        };

        yazi = {
          enable = true;
          enableBashIntegration = true;
          enableNushellIntegration = true;
          settings = {
            log.enabled = false;
            mgr = {
              show_hidden = false;
              sort_by = "natural";
              sort_dir_first = true;
              sort_reverse = false;
              show_symlink = true;
              linemode = "none";
            };
            preview = {
              wrap = "yes";
              image_filter = "triangle";
            };
          };
        };

        yt-dlp = {
          enable = true;
          settings = {};
        };

        zathura.enable = true;
        zellij.enable = true;

        zen-browser = {
          enable = true;
          policies = {
            AutofillAddressEnabled = true;
            AutofillCreditCardEnabled = false;
            DisableAppUpdate = true;
            DisableFeedbackCommands = true;
            DisableFirefoxStudies = true;
            DisablePocket = true;
            DisableTelemetry = true;
            DontCheckDefaultBrowser = true;
            NoDefaultBookmarks = true;
            OfferToSaveLogins = false;
            EnableTrackingProtection = {
              Value = true;
              Locked = true;
              Cryptomining = true;
              Fingerprinting = true;
            };
          };
          profiles."default" = {
            containersForce = true;
            containers = {
              Personal = {
                color = "purple";
                icon = "fingerprint";
                id = 1;
              };
              Finance = {
                color = "green";
                icon = "dollar";
                id = 2;
              };
              Research = {
                color = "orange";
                icon = "circle";
                id = 3;
              };
              Shopping = {
                color = "yellow";
                icon = "cart";
                id = 4;
              };
            };
            spacesForce = true;
            spaces = let
              containers = config.programs.zen-browser.profiles."default".containers;
            in {
              "Home" = {
                id = "217e852f-6bfa-4303-9468-1b5fe7e28fb0";
                icon = "🏠";
                container = containers."Personal".id;
                position = 1000;
              };
              "Accounts" = {
                id = "9b66fa68-88b2-4a90-9ae9-0cee470d46c1";
                icon = "💳";
                container = containers."Personal".id;
                position = 2000;
              };
              "Research" = {
                id = "ce3a4ea9-43a3-44ce-8bd0-716384ab8df0";
                icon = "🔬";
                container = containers."Research".id;
                position = 3000;
              };
              "CSE" = {
                id = "15596769-b3ae-47e1-920c-ebc77aab8d8c";
                icon = "🖥️";
                container = containers."Research".id;
                position = 4000;
              };
              "Hobbies" = {
                id = "73a7b38b-3111-41bc-a1da-2d0c40779cb0";
                icon = "🎨";
                container = containers."Personal".id;
                position = 5000;
              };
            };
          };
        };
      };
    };
  };
}
