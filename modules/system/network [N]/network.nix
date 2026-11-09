# Networking (NixOS): NetworkManager. The firewall is on by default; features
# that need ports open them themselves (e.g. steam remotePlay).
{
  flake.modules.nixos.network.networking.networkmanager.enable = true;
}
