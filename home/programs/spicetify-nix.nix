{
  inputs,
  pkgs,
  ...
}: let
  spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
in {
imports = [ inputs.spicetify-nix.homeManagerModules.spicetify ];

  programs.spicetify = {
    enable = true;
    enabledExtensions = with spicePkgs.extensions; [
      adblockify
      keyboardShortcut
      savePlaylists
      shuffle 
    ];
    theme = spicePkgs.themes.text; 
    # colorScheme = "mocha";
  };
}
