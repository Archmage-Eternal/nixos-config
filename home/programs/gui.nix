{pkgs, ...}: {
  home.packages = with pkgs; [
    # Media Creation & Editing
    gimp # Image editor for photo retouching and graphic design
    obs-studio # Screen recording and livestreaming software
    krita # Free and open source painting application

    # Media Playback & Management
    vlc # Versatile media player supporting most audio and video formats
    calibre # Ebook management software for reading, converting, and organizing

    # Office Productivity
    libreoffice # Full-featured office suite (word processor, spreadsheets, etc.)

    # System Utilities
    pwvucontrol # Pulseaudio volume and device control GUI
    openrgb # Control periphral lighting

    bottles
  ];
}
