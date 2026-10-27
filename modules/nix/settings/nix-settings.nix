# Core nix daemon settings (NixOS).
{
  flake.modules.nixos.nix-settings = {
    nix.settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
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
