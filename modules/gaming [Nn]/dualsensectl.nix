# DualSense controller CLI (home-manager).
{
  flake.modules.homeManager.dualsensectl = {pkgs, ...}: {
    home.packages = [pkgs.dualsensectl];
  };
}
