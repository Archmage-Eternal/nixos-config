{ ... }:
{
  imports = [
  ./dbus.nix
  ./dconf.nix
  ./greetd.nix
  # ./niri.nix  # Temporarily disabled for initial install
  ./quickshell.nix
  ./stylix.nix
  ./xdg-portal.nix
  ./xserver.nix
  ];
}
