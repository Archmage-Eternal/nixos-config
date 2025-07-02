{ pkgs, ... }:

{
  home.packages = with pkgs; [

    # ──────────────── MEDIA CREATION & EDITING ────────────────

    # Audio editor and recorder with multi-track support
    audacity

    # Image editor for photo retouching and graphic design
    gimp

    # GTK-based video editor using GStreamer
    pitivi

    # Screen recording and livestreaming software
    obs-studio

    # ──────────────── MEDIA PLAYBACK & MANAGEMENT ────────────────

    # Versatile media player supporting most audio and video formats
    vlc

    # Ebook management software for reading, converting, and organizing
    calibre

    # ──────────────── OFFICE PRODUCTIVITY ────────────────

    # Full-featured office suite (word processor, spreadsheets, etc.)
    libreoffice

    # ──────────────── SYSTEM UTILITIES ────────────────

    # GUI tool for managing disks and partitions
    gnome-disk-utility

    # Pulseaudio volume and device control GUI
    pavucontrol

    # ──────────────── SCRIPTING & SYSTEM CONFIGURATION ────────────────

    # GUI dialogs for use in shell scripts
    zenity

    # Editor for modifying GNOME and dconf settings
    dconf-editor

    # ──────────────── AUDIO STREAMING ────────────────

    # Streams PC audio to other devices over the network
    soundwireserver

  ];
}

