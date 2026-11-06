# caelestia shell input (Quickshell-based desktop shell, not the full dots).
{
  flake-file.inputs.caelestia-shell = {
    url = "github:caelestia-dots/shell";
    inputs.nixpkgs.follows = "nixpkgs";
  };
}
