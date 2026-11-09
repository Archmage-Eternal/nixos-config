# stylix input (fonts + cursor only; targets are opt-in, see stylix.nix).
{
  flake-file.inputs.stylix = {
    url = "github:nix-community/stylix";
    inputs.nixpkgs.follows = "nixpkgs";
  };
}
