# SteamCMD (NixOS): Valve's command-line Steam client, used to install and
# update dedicated game servers. Unfree (redistributable): the host needs the
# `allow-unfree` aspect.
{
  flake.modules.nixos.steamcmd = {pkgs, ...}: {
    environment.systemPackages = [pkgs.steamcmd];
  };
}
