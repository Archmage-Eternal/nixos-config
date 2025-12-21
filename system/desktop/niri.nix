{inputs, ...}: {
  nixpkgs.overlays = [inputs.niri-flake.overlays.niri];

  imports = [inputs.niri-flake.nixosModules.niri];

  programs.niri = {
    enable = false;  # Enable after first boot
  };
}
