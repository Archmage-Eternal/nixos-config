# MangoWM (NixOS). Stub: enabled only, no settings/keybind translator yet.
{inputs, ...}: {
  flake.modules.nixos.mangowm = {
    imports = [inputs.mangowm.nixosModules.mango];

    programs.mango.enable = true;
  };
}
