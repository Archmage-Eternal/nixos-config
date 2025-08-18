{ inputs, pkgs, host, ... }:
let
nixCats = inputs.nixCats.packages.${pkgs.system}.default;
in
{
home.packages = [nixCats];	
}
