# MangoWM (NixOS + Home-Manager). NixOS half enables the compositor
# system-wide; the HM half enables per-user config (binds live in
# bind-translate.nix).
{inputs, ...}: {
  flake.modules.nixos.mangowm = {
    imports = [inputs.mangowm.nixosModules.mango];

    programs.mango.enable = true;
  };

  flake.modules.homeManager.mangowm = {
    imports = [inputs.mangowm.hmModules.mango];

    wayland.windowManager.mango.enable = true;
  };
}
