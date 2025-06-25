{ pkgs, ... }:
{
  home.packages = with pkgs; [
    audacity
    dconf-editor
    gimp
    gnome-disk-utility
    libreoffice
    obs-studio
    pavucontrol                       # pulseaudio volume controle (GUI)
    pitivi                            # video editing
    soundwireserver
    vlc
    zenity
  ];
}
