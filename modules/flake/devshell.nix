# Dev shell collector. Features contribute tools / other shells; this builds
# `devShells.default` from them (a derivation can't be merged across modules).
{
  perSystem = {
    config,
    lib,
    pkgs,
    ...
  }: {
    options.devshell = {
      packages = lib.mkOption {
        type = lib.types.listOf lib.types.package;
        default = [];
      };
      inputsFrom = lib.mkOption {
        type = lib.types.listOf lib.types.package;
        default = [];
      };
    };
    config.devShells.default = pkgs.mkShell {inherit (config.devshell) packages inputsFrom;};
  };
}
