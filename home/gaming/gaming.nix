{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    # Windows Compatibility
    winetricks # Scriptable wrapper for Wine configuration
    wineWowPackages.waylandFull # Wine build with Wayland support

    # Minecraft Launcher
    prismlauncher

    # Memory scanners
    scanmem
    med

  ];
}
