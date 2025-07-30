{pkgs, ...}: {
  home.packages = with pkgs; [
    # CLI Replacements
    eza # Enhanced ls with icons and colors
    fd # Faster alternative to find with simpler syntax
    ripgrep # Fast grep alternative with regex and glob support
    jq # JSON processor for command-line filters and transformations

    # General CLI Utilities
    htop # System monitor with interactive UI
    killall # Kill processes by name
    file # File identification based on content, not extension
    ncdu # Disk usage viewer in the terminal
    dysk # CLI disk information utility
    wl-clipboard # Clipboard copy/paste tool for Wayland
    wget # Wget-based download utility
    nitch # Displays system info in terminal
    onefetch # Git repository summary viewer with language stats
    libnotify # Clipboard and notification utility
    shfmt # Bash formatter
    xdg-utils # Open files/URLs using desktop defaults
    yazi # Terminal file manager

    # Development & Diagnostic Tools
    bitwise # Visual interactive bit calculator
    playerctl # Media key control for MPRIS-compatible players
    ffmpeg # FFmpeg CLI for media conversion and processing
    mimeo # Copy/paste URL and open with default handler

    # Media & Visual Tools
    imv # Image viewer for X/Wayland
    mpv # Video/audio player for the terminal
    tdf # PDF viewer for terminal (lightweight)
    ani-cli # Stream and search anime from terminal
    yt-dlp-light # YouTube downloader with clipboard support
    swappy # CLI PDF/image annotation utility

    # Personal Productivity
    nb # CLI note-taking and knowledge management system

    # CLI Screensavers & Visual Toys
    cbonsai # ASCII bonsai tree animation
    cmatrix # Matrix-style rain animation
    pipes # Animated pipe drawings
    sl # Steam locomotive animation (for mistyped 'sl')
    tty-clock # ASCII digital clock for the terminal

    # System Alerting / Power
    poweralertd # Warn on power loss or battery drop
    wavemon # Show Wi-Fi signal strength and stats in terminal
    caligula # TUI disk imager for raw device copying
    libratbag # Manage configuration for gaming mice (daemon interface)
    dualsensectl # Control and configure DualSense controller features
    asusctl # Control ASUS laptop-specific hardware and RGB via CLI

    # Windows Compatibility
    winetricks # Scriptable wrapper for Wine configuration
    wineWowPackages.wayland # Wine build with Wayland support
  ];
}
