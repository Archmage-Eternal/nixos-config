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
    # Lua is the preferred config language (hyprlang is deprecated since 0.55).
    configType = "lua";
  };
}
