# mangowm input.
{
  flake-file.inputs.mangowm = {
    url = "github:mangowm/mango";
    inputs.nixpkgs.follows = "nixpkgs";
  };
}
