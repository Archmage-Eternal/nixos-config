{pkgs, ...}: {
  xdg.portal = {
    enable = true;
    extraPortals = [
      pkgs.xdg-desktop-portal-gtk
      pkgs.xdg-desktop-portal-gnome
    ];
    config = {
      common = {
        default = ["gtk" "gnome"];
        "org.freedesktop.impl.portal.FileChooser" = ["gtk"];
      };
      niri = {
        default = ["gnome" "gtk"];
        "org.freedesktop.impl.portal.FileChooser" = ["gtk"];
      };
      hyprland.default = [
        "gtk"
        "hyprland"
      ];
    };
  };
}
