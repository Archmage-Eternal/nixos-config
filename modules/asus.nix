{...}: {
  flake = {
    nixosModules.asus = {...}: {
      services = {
        supergfxd.enable = true;
        asusd.enable = true;
      };
    };
  };
}
