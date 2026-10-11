{
  flake-file.inputs.import-tree.url = "github:vic/import-tree";

  # Have flake-file generate the outputs line directly (import-tree over
  # ./modules), so a separate outputs.nix file isn't needed.
  flake-file.outputs = "dendritic";
}
