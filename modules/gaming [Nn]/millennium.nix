# Millennium: Steam client mod. Swaps programs.steam.package for the patched
# client via the flake's overlay. Import alongside `steam`.
{inputs, ...}: {
  flake.modules.nixos.millennium = {pkgs, ...}: {
    nixpkgs.overlays = [inputs.millennium.overlays.default];
    programs.steam.package = pkgs.millennium-steam;
  };
}
