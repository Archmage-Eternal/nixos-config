# Flake scaffolding. flake-file's dendritic module sets up flake-parts,
# import-tree, flake-file itself and the outputs line (import-tree over
# ./modules). Only the pins that differ from its defaults live here.
{inputs, ...}: {
  imports = [inputs.flake-file.flakeModules.dendritic];
  flake-file.inputs.nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  systems = ["x86_64-linux"];
}
