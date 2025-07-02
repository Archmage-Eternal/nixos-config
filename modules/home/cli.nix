{ pkgs, ... }:

{
  home.packages = with pkgs; [

    # ──────────────── CLI REPLACEMENTS ────────────────

    # Enhanced ls with icons and colors
    eza

    # Faster alternative to find with simpler syntax
    fd

    # Fast grep alternative with regex and glob support
    ripgrep

    # Tree view generator for directories
    treefmt

    # Enhanced man pages with simplified command explanations
    tldr

    # Extra man pages 
    man-pages

    # JSON processor for command-line filters and transformations
    jq

    # ──────────────── GENERAL CLI UTILITIES ────────────────

    # System monitor with interactive UI
    htop

    # Kill processes by name
    killall

    # Watch files and run commands on change
    entr

    # File identification based on content, not extension
    file

    # Disk usage viewer in the terminal
    ncdu

    # CLI disk information utility
    dysk
    
    # Archive extraction utility for .zip files
    unzip

    # Command-line interface to OpenSSL utilities
    openssl

    # Clipboard copy/paste tool for Wayland
    wl-clipboard

    # Wget-based download utility
    wget

    # Displays system info in terminal
    nitch

    # Git repository summary viewer with language stats
    onefetch

    # Clipboard and notification utility
    libnotify

    # Remove files by sending them to the trash
    gtrash

    # Clipboard manager and GUI
    lowfi

    # Bash formatter
    shfmt

    # Open files/URLs using desktop defaults
    xdg-utils

    # ──────────────── DEVELOPMENT & DIAGNOSTIC TOOLS ────────────────

    # Show binary and hex output
    hexdump

    # Lightweight hex viewer for the terminal
    hevi

    # Visual interactive bit calculator
    bitwise

    # PulseAudio volume control from CLI
    pamixer

    # Media key control for MPRIS-compatible players
    playerctl

    # Programmer calculator for quick base conversions
    programmer-calculator

    # CLI hex inspection, patching, and reverse engineering
    xxd

    # Binary analysis utility
    binsider

    # FFmpeg CLI for media conversion and processing
    ffmpeg

    # Copy/paste URL and open with default handler
    mimeo

    # ──────────────── MEDIA & VISUAL TOOLS ────────────────

    # Image viewer for X/Wayland
    imv

    # Video/audio player for the terminal
    mpv

    # PDF viewer for terminal (lightweight)
    tdf

    # Stream and search anime from terminal
    ani-cli

    # YouTube downloader with clipboard support
    yt-dlp-light

    # CLI PDF/image annotation utility
    swappy

    # ──────────────── SCREENCAST RECORDING ────────────────

    # Terminal session recorder
    asciinema

    # Convert asciinema recordings to SVG animations
    asciinema-agg

    # ──────────────── TYPING PRACTICE ────────────────

    # Fast, minimal typing test in terminal
    smassh

    # Simple typing speed tracker
    toipe

    # Typing test with word stats and UI
    ttyper

    # ──────────────── PERSONAL PRODUCTIVITY ────────────────

    # CLI note-taking and knowledge management system
    nb

    # Zettelkasten-style note-taking tool
    zk

    # CLI tool for Advent of Code
    aoc-cli

    # Translate text from terminal using Google Translate
    gtt

    # ──────────────── CLI SCREENSAVERS & VISUAL TOYS ────────────────

    # ASCII bonsai tree animation
    cbonsai

    # Matrix-style rain animation
    cmatrix

    # Animated pipe drawings
    pipes

    # Steam locomotive animation (for mistyped 'sl')
    sl

    # ASCII digital clock for the terminal
    tty-clock

    # ──────────────── SYSTEM ALERTING / POWER ────────────────

    # Warn on power loss or battery drop
    poweralertd

    # Show Wi-Fi signal strength and stats in terminal
    wavemon

    # TUI disk imager for raw device copying
    caligula

    # ──────────────── APP LAUNCHING / FUZZY SEARCH ────────────────

    # Minimal fuzzy launcher for terminal commands
    woomer

    # ──────────────── WINDOWS COMPATIBILITY ────────────────

    # Scriptable wrapper for Wine configuration
    winetricks

    # Wine build with Wayland support
    wineWowPackages.wayland

  ];
}

