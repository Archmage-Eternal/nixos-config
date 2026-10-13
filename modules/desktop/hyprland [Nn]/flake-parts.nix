# hyprland input + binary cache (added once; only used when hyprland is).
{inputs, ...}: {
  flake-file.inputs.hyprland.url = "github:hyprwm/Hyprland";

  flake.modules.nixos.hyprland.nix.settings = {
    substituters = ["https://hyprland.cachix.org"];
    trusted-substituters = ["https://hyprland.cachix.org"];
    trusted-public-keys = [
      "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
    ];
  };
}
