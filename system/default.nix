{ ... }:
{
  imports = [
    ./programs
    ./boot.nix
    ./system.nix
    ./hardware.nix
    ./xserver.nix
    ./network.nix
    ./nvidia.nix
    ./audio.nix
    ./security.nix
    ./sops-nix.nix
    ./user.nix
    ./wayland.nix
    ./quickshell.nix
    # ./stylix.nix
  ];
}
