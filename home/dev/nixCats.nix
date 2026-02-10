{ inputs, pkgs, host, ... }:
let
nixCats = inputs.nixCats.packages.${pkgs.stdenv.hostPlatform.system}.default;
in
{
home.packages = [nixCats];	
}
