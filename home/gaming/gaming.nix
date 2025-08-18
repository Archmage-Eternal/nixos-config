{
  pkgs,
  inputs,
  ...
}: {
  home.packages = with pkgs; [
    ## Utils
    gamemode 

    # Windows Compatibility
    winetricks # Scriptable wrapper for Wine configuration
    wineWowPackages.wayland # Wine build with Wayland support
    # inputs.nix-gaming.packages.${pkgs.system}.wine-ge

    ## Minecraft
    prismlauncher
  ];
}
