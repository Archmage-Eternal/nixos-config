# Wine: Windows compatibility layer (home-manager).
{
  flake.modules.homeManager.wine = {pkgs, ...}: {
    home.packages = with pkgs; [
      wineWow64Packages.waylandFull
      winetricks
    ];
    # Stop wine from generating .desktop menu entries for installed programs.
    home.sessionVariables.WINEDLLOVERRIDES = "winemenubuilder.exe=d";
  };
}
