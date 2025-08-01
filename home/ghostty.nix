{
  inputs,
  pkgs,
  host,
  ...
}: let
  ghostty = inputs.ghostty.packages.${pkgs.system}.default;
in {
  home.packages = [ghostty];
}
