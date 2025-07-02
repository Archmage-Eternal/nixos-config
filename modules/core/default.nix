{ ... }:
{
  imports = [
    ./bootloader.nix
    ./bluetooth.nix
    ./configuration-core.nix
    ./hardware.nix
    ./xserver.nix
    ./network.nix
    ./nh.nix
    ./nvidia.nix
    ./pipewire.nix
    ./security.nix
    ./steam.nix
    ./flatpak.nix
    ./user.nix
    ./wayland.nix
    ./virtualization.nix
  ];
}
