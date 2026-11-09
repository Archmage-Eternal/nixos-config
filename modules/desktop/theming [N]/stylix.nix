# Theming via stylix (NixOS): fonts and cursor only.
#
# autoEnable = false: no app is themed unless its target is enabled
# explicitly. base16Scheme is still required by stylix (the palette file is
# always generated) but colours nothing while no colour target is on.
# Home-Manager inherits enable/autoEnable/cursor/fonts from here automatically.
{
  flake.modules.nixos.theming = {
    inputs,
    pkgs,
    ...
  }: {
    imports = [inputs.stylix.nixosModules.stylix];

    stylix = {
      enable = true;
      autoEnable = false;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
      polarity = "dark";

      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
        size = 24;
      };

      fonts = {
        monospace = {
          package = pkgs.nerd-fonts.iosevka-term;
          name = "Iosevka Term NF";
        };
        sansSerif = {
          package = pkgs.noto-fonts;
          name = "Noto Sans";
        };
        serif = {
          package = pkgs.noto-fonts;
          name = "Noto Serif";
        };
        emoji = {
          package = pkgs.noto-fonts-color-emoji;
          name = "Noto Color Emoji";
        };
      };

      # Only the font targets: install the packages and set fontconfig defaults.
      targets = {
        font-packages.enable = true;
        fontconfig.enable = true;
      };
    };
  };
}
