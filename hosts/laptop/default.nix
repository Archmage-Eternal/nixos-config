{ pkgs, config, ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./../../system
  ];
}
