{...}: {
  flake = {
    nixosModules.core = {
      pkgs,
      inputs,
      ...
    }: {
      boot = {
        kernelPackages = pkgs.linuxPackages_zen;
        kernel.sysctl = {"vm.max_map_count" = 2147483642;};
        loader = {
          systemd-boot.enable = true;
          efi.canTouchEfiVariables = true;
          systemd-boot.configurationLimit = 10;
        };
        supportedFilesystems = ["ntfs"];
      };

      time.timeZone = "Asia/Kolkata";
      i18n.defaultLocale = "en_US.UTF-8";
      system.stateVersion = "24.05";

      nix = {
        settings = {
          auto-optimise-store = true;
          experimental-features = [
            "nix-command"
            "flakes"
          ];
          substituters = [
            "https://nix-community.cachix.org"
            "https://ghostty.cachix.org"
            "https://nix-gaming.cachix.org"
          ];
          trusted-public-keys = [
            "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
            "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
            "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
          ];
        };
      };

      nixpkgs = {
        overlays = [inputs.nur.overlays.default];
        config.allowUnfree = true;
      };

      hardware = {
        enableRedistributableFirmware = true;
        bluetooth = {
          enable = true;
          powerOnBoot = true;
        };
      };

      services = {
        dbus.enable = true;
        fstrim.enable = true;
      };

      security.sudo.enable = true;
    };
  };
}
