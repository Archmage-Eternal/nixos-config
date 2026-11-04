# Millennium: Steam client mod. Swaps programs.steam.package for the patched
# client via the flake's overlay. Import alongside `steam`.
{
  flake.modules.nixos.millennium = {
    inputs,
    pkgs,
    ...
  }: {
    nixpkgs.overlays = [inputs.millennium.overlays.default];
    programs.steam.package = pkgs.millennium-steam;
  };
}
