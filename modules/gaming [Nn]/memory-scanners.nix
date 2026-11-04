# Memory scanners / game trainers: scanmem and med (home-manager).
{
  flake.modules.homeManager.memory-scanners = {pkgs, ...}: {
    home.packages = with pkgs; [
      scanmem
      med
    ];
  };
}
