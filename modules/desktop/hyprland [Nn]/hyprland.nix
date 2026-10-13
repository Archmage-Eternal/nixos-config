# Hyprland (NixOS + Home-Manager).
{
  flake.modules.nixos.hyprland = {
    inputs,
    pkgs,
    ...
  }: {
    imports = [inputs.hyprland.nixosModules.default];

    programs.hyprland = {
      enable = true;
      withUWSM = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
  };

  flake.modules.homeManager.hyprland.wayland.windowManager.hyprland = {
    enable = true;
    package = null;
    portalPackage = null;
    # Our settings are hyprlang-style; pin configType since the HM default
    # changed to "lua".
    configType = "hyprlang";
  };
}
