# Theming via stylix: fonts and cursor only.
#
# autoEnable = false: no app is themed unless its target is enabled
# explicitly. base16Scheme is still required by stylix (the palette file is
# always generated) but colours nothing while no colour target is on.
# Home-Manager inherits enable/autoEnable/cursor/fonts from the NixOS side
# automatically; the HM half below only widens where the cursor is applied.
{inputs, ...}: {
  flake.modules.nixos.theming = {pkgs, ...}: {
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

  # Apply the stylix cursor beyond XCURSOR_*: GTK settings (needs the `dconf`
  # NixOS aspect), X11 resources and hyprcursor env. Values come from
  # stylix.cursor via home.pointerCursor. hyprcursor has no effect for an
  # XCursor-only theme (see TODO item 16).
  flake.modules.homeManager.theming = {
    gtk.enable = true;
    home.pointerCursor = {
      gtk.enable = true;
      x11.enable = true;
      hyprcursor.enable = true;
    };
  };
}
