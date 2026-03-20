{...}: {
  flake = {
    nixosModules.flatpak = {inputs, ...}: {
      imports = [inputs.nix-flatpak.nixosModules.nix-flatpak];

      services.flatpak = {
        enable = false;
        packages = [];
        update.onActivation = true;
      };
    };
  };
}
