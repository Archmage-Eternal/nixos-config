{...}: {
  flake = {
    nixosModules.disko = {inputs, ...}: {
      imports = [inputs.disko.nixosModules.disko];
    };
  };
}
