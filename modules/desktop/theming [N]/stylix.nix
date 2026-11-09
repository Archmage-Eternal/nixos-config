# Theming via stylix: colours, fonts and cursor for GTK, Qt and every app that
# has a stylix target.
#
# autoEnable = true: each installed app with a target is themed automatically.
# Opt a single app out with `stylix.targets.<app>.enable = false`. Home-Manager
# inherits enable/autoEnable/cursor/fonts/colours from the NixOS side
# automatically, so the HM half below only carries per-app options.
{inputs, ...}: {
  flake.modules.nixos.theming = {pkgs, ...}: {
    imports = [
      inputs.stylix.nixosModules.stylix
      # The gtk target's home-manager half writes dconf settings.
      inputs.self.modules.nixos.dconf
    ];

    stylix = {
      enable = true;
      autoEnable = true;
      base16Scheme = "${pkgs.base16-schemes}/share/themes/tokyo-night-dark.yaml";
      polarity = "dark";

      cursor = {
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Ice";
        size = 24;
      };

      fonts = {
        sizes = {
          desktop = 12;
          applications = 15;
          terminal = 17;
          popups = 17;
        };
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
    };
  };

  flake.modules.homeManager.theming = {
    # The zen-browser target needs to know which profiles to style.
    stylix.targets.zen-browser.profileNames = ["default"];
    # rofi isn't installed; its target triggers a deprecation warning
    # (programs.rofi.font renamed) when autoEnable is on.
    stylix.targets.rofi.enable = false;
  };
}
