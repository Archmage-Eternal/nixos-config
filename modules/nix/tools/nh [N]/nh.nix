# nh (NixOS): friendlier front end for nixos-rebuild (`nh os switch`) and for
# cleaning old generations. It wraps nix-output-monitor itself. It owns garbage
# collection (nix.gc is off): weekly, keeping the last 7 days and at least 5
# generations.
{
  flake.modules.nixos.nh.programs.nh = {
    enable = true;
    clean = {
      enable = true;
      extraArgs = "--keep-since 7d --keep 5";
    };
    # Where the config lives on the host; nh reads it from NH_FLAKE.
    flake = "/home/david/nixos-config";
  };
}
