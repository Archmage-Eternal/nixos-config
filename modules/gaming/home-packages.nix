{...}: {
  flake.homeModules.gaming = {pkgs}: {
    home.packages = with pkgs; [
      winetricks
      wineWowPackages.waylandFull
      prismlauncher
      scanmem
      med
      samrewritten
    ];
  };
}
