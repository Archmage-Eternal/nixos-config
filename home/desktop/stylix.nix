{config, ...}: {
  stylix.targets = {
    spicetify.enable = false;
    zen-browser.profileNames = [ "default" ];
  };

  gtk.gtk4.theme = config.gtk.theme;
}
