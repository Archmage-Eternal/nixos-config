{...}: {
  flake = {
    nixosModules.services = {...}: {
      services.hardware.openrgb.enable = true;
    };
  };
}
