# dconf: GSettings backend used by GTK/GNOME-stack apps (NixOS). Required by
# anything writing `dconf.settings` from home-manager (e.g. gtk.enable).
{
  flake.modules.nixos.dconf.programs.dconf.enable = true;
}
