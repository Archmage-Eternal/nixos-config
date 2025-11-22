{pkgs, ...}: {
  home.packages = with pkgs; [
    calibre
    gimp
    krita
    libreoffice
    obs-studio
    openrgb-with-all-plugins
    pwvucontrol
    qbittorrent-enhanced
    xfce.thunar
    vlc
    zotero-beta
  ];
}
