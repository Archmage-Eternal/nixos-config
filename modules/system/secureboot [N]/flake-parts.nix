# lanzaboote input. Pinned to v1.2.0 (the version recommended in lanzaboote docs; v1.0.0 conflicted with the nixpkgs
# bootspec assertion).
{
  flake-file.inputs.lanzaboote = {
    url = "github:nix-community/lanzaboote/v1.2.0";
    inputs.nixpkgs.follows = "nixpkgs";
  };
}
