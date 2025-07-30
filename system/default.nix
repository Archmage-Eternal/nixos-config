{ ... }:
{
  imports = [
    ./boot.nix
    ./locale.nix
    ./nix.nix
    ./desktop
    ./hardware
    ./programs
    ./security
    ./services
    ./users
  ];
}
