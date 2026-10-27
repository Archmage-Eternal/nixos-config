# Core nix daemon settings (NixOS): daemon behaviour + binary caches.
{
  flake.modules.nixos.nix-settings = {
    nix.settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      # Binary cache substituters. Collector target: per-service caches
      # (hyprland, ghostty, ...) merge into these same lists from their own
      # features via list concatenation — the Collector pattern.
      substituters = [
        "https://nix-community.cachix.org"
      ];
      trusted-substituters = [
        "https://hydra.nixos.org/"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };

    # Weekly GC, keep the last 2 weeks of roots. Port add: legacy had no GC,
    # store grows unbounded without it.
    nix.gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
  };
}
