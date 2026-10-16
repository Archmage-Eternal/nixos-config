# Pre-commit hook: format (via treefmt) + full `nix flake check` before
# every commit. Installed by entering the dev shell (`nix develop`), which
# symlinks .git/hooks/pre-commit via git-hooks.nix's shellHook.
#
# check.enable = false: do NOT add this to `checks` (see flake-parts.nix for
# why — avoids a flake-check -> pre-commit-check -> flake-check recursion).
{inputs, ...}: {
  imports = [inputs.git-hooks.flakeModule];

  perSystem = {
    config,
    pkgs,
    ...
  }: {
    pre-commit = {
      check.enable = false;
      settings.hooks = {
        treefmt.enable = true;
        flake-check = {
          enable = true;
          name = "flake-check";
          entry = "${pkgs.nix}/bin/nix flake check";
          pass_filenames = false;
        };
      };
    };

    devShells.default = config.pre-commit.devShell;
  };
}
