# Binary cache substituters (NixOS).
#
# This is the base/collector target. Per-service caches (e.g. hyprland,
# ghostty) are contributed from their own features via the same
# nix.settings.substituters / trusted-public-keys attributes, which merge
# (list concatenation) across modules — the Collector pattern.
{
  flake.modules.nixos.substituters = {
    nix.settings = {
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
  };
}
