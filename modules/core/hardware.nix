{ inputs, pkgs, ... }:
let
  hyprland-pkgs =
    inputs.hyprland.inputs.nixpkgs.legacyPackages.${pkgs.stdenv.hostPlatform.system};
in
{
  hardware = {
  enableRedistributableFirmware = true;
    graphics = {
      enable = true;
      package = hyprland-pkgs.mesa;
      extraPackages = with pkgs; [
        vaapiVdpau
        libvdpau-va-gl
      ];
    };
    bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  logitech.wireless = {
  enable = true;
  enableGraphical = true;
  };
  keyboard.qmk.enable = true;
  };
}
