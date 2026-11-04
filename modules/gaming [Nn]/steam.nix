# Steam. NixOS half owns the client; programs.steam already enables the
# steam-hardware udev rules (see TODO item 14).
{
  flake.modules.nixos.steam = {pkgs, ...}: {
    programs.steam = {
      enable = true;
      remotePlay.openFirewall = true;
      protontricks.enable = true;
      gamescopeSession.enable = true;
      extraCompatPackages = [pkgs.proton-ge-bin];
    };
  };

  # SamRewritten: Steam achievement/stat manager.
  flake.modules.homeManager.steam = {pkgs, ...}: {
    home.packages = [pkgs.samrewritten];
  };
}
