# Prism Launcher: Minecraft launcher (home-manager).
{
  flake.modules.homeManager.prismlauncher = {pkgs, ...}: {
    home.packages = [pkgs.prismlauncher];
  };
}
