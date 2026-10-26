{
  flake.modules.nixos.disko = {inputs, ...}: {
    imports = [inputs.disko.nixosModules.disko];
  };
}
