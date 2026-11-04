# git-hooks.nix input. Wired through devShells only (not `checks`) to avoid
# a `nix flake check` -> pre-commit-check -> `nix flake check` recursion if a
# hook ever calls flake check itself.
{inputs, ...}: {
  flake-file.inputs.git-hooks = {
    url = "github:cachix/git-hooks.nix";
    inputs.nixpkgs.follows = "nixpkgs";
  };
}
