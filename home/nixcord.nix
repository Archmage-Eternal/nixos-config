{inputs, ...}: {
  imports = [ inputs.nixcord.homeModules.nixcord ];

  programs.nixcord = {
    enable = true;          # Enable Nixcord (It also installs Discord)
    discord.enable = false;  # Discord
    vesktop.enable = true;  # Vesktop
    dorion.enable = false;   # Dorion
    # quickCss = "some CSS";  # quickCSS file
    config = {
      # useQuickCss = true;   # use out quickCSS
      # themeLinks = [        # or use an online theme
      #   "https://raw.githubusercontent.com/link/to/some/theme.css"
      # ];
      frameless = true;                   # Set some Vencord options
      plugins = {
        hideAttachments.enable = true;    # Enable a Vencord plugin
        ignoreActivities = {              # Enable a plugin and set some options
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
