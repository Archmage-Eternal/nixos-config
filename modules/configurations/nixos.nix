{
  lib,
  config,
  inputs,
  ...
}: {
  options.configurations.nixos = lib.mkOption {
    type = lib.types.lazyAttrsOf (
      lib.types.submodule {
        options.module = lib.mkOption {
          type = lib.types.deferredModule;
        };
      }
    );
    default = {};
  };

  config.flake.nixosConfigurations =
    lib.mapAttrs (
      _name: {module}:
        inputs.nixpkgs.lib.nixosSystem {
          modules = [module];
          specialArgs = {inherit inputs;};
        }
    )
    config.configurations.nixos;
}
