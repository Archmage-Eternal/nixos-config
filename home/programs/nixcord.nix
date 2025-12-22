{inputs, ...}: {
  imports = [inputs.nixcord.homeModules.nixcord];

  programs.nixcord = {
    enable = true; # Enable Nixcord (It also installs Discord)
    discord = {
      enable = false;
      vencord.enable = false;
      equicord.enable = false;
    };
    vesktop.enable = false;
    equibop.enable = true;
    dorion.enable = false; # Dorion
    # quickCss = "some CSS";  # quickCSS file
    config = {
      # useQuickCss = true;   # use out quickCSS
      # themeLinks = [        # or use an online theme
      #   "https://raw.githubusercontent.com/link/to/some/theme.css"
      # ];
      frameless = true;
      plugins = {
        hideMedia.enable = true;
        ignoreActivities = {
          enable = true;
          ignorePlaying = true;
          ignoreWatching = true;
          # ignoredActivities = [ "someActivity" ];
        };
      };
    };
    extraConfig = {
      # Some extra JSON config here
    };
  };
}
