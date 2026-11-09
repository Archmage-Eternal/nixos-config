# nixcord input (declarative Discord clients/mods). Shares our pins instead of
# locking its own copies; nix-darwin is unused on Linux.
{
  flake-file.inputs.nixcord = {
    url = "github:4evy/nixcord";
    inputs = {
      nixpkgs.follows = "nixpkgs";
      nixpkgs-ci.follows = "nixpkgs";
      nixpkgs-packages.follows = "nixpkgs";
      home-manager.follows = "home-manager";
      treefmt-nix.follows = "treefmt-nix";
      nix-darwin.follows = "";
    };
  };
}
