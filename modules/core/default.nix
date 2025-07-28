{ ... }:
{
  imports = [
    ./boot.nix
    ./bluetooth.nix
    ./configuration-core.nix
    ./hardware.nix
    ./xserver.nix
    ./network.nix
    ./nh.nix
    ./nvidia.nix
    ./audio.nix
    ./security.nix
    ./sops-nix.nix
    ./steam.nix
    ./flatpak.nix
    ./user.nix
    ./wayland.nix
    ./virtualization.nix
    ./quickshell.nix
    # ./stylix.nix
  ];
}
