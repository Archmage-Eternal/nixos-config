# Allow unfree packages for the NixOS system build (NixOS).
#
# mkNixos builds its own nixpkgs for the nixosSystem, so the system needs its
# own allowUnfree. Home-Manager (useGlobalPkgs = true) reuses this system
# pkgs, so no separate HM allowUnfree is required. Shared across hosts.
{
  flake.modules.nixos.allow-unfree = {
    nixpkgs.config.allowUnfree = true;
  };
}
