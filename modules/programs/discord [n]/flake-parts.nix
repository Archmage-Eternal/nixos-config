# nixcord input (declarative Discord clients/mods).
{
  flake-file.inputs.nixcord = {
    url = "github:4evy/nixcord";
    inputs = {
      nixpkgs.follows = "nixpkgs";
      home-manager.follows = "home-manager";
    };
  };
}
