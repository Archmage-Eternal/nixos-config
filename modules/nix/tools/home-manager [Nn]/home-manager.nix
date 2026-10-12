# Wires the home-manager NixOS module + shared HM settings once.
{inputs, ...}: {
  flake.modules.nixos.home-manager = {
    imports = [inputs.home-manager.nixosModules.home-manager];

    home-manager = {
      useUserPackages = true;
      useGlobalPkgs = true;
      backupFileExtension = "backup";
    };
  };
}
