{pkgs, ...}: {
  home.packages = with pkgs; [
    # CLI Replacements
    eza # Enhanced ls with icons and colors
    fd # Faster alternative to find with simpler syntax
    jq # JSON processor for command-line filters and transformations
    ripgrep # Fast grep alternative with regex and glob support

    # General CLI Utilities
    dysk # CLI disk information utility
    file # File identification based on content, not extension
    glow
    killall # Kill processes by name
    libnotify # Clipboard and notification utility
    ncdu # Disk usage viewer in the terminal
    nitch # Displays system info in terminal
    nvtopPackages.full
    onefetch # Git repository summary viewer with language stats
    shfmt # Bash formatter
    tealdeer
    trash-cli
    w3m
    wget # Wget-based download utility
    wl-clipboard # Clipboard copy/paste tool for Wayland
    xdg-utils # Open files/URLs using desktop defaults
    yazi # Terminal file manager

    # Development & Diagnostic Tools
    bitwise # Visual interactive bit calculator
    ffmpeg # FFmpeg CLI for media conversion and processing
    mimeo # Copy/paste URL and open with default handler
    playerctl # Media key control for MPRIS-compatible players

    # Media & Visual Tools
    ani-cli # Stream and search anime from terminal
    gallery-dl
    imv # Image viewer for X/Wayland
    mpv # Video/audio player for the terminal
    swappy # CLI PDF/image annotation utility
    tdf # PDF viewer for terminal (lightweight)
    yt-dlp # YouTube downloader with clipboard support

    # Personal Productivity
    nb # CLI note-taking and knowledge management system

    # CLI Screensavers & Visual Toys
    cbonsai # ASCII bonsai tree animation
    cmatrix # Matrix-style rain animation
    pipes # Animated pipe drawings
    sl # Steam locomotive animation (for mistyped 'sl')
    tty-clock # ASCII digital clock for the terminal

    # System Alerting / Power
    caligula # TUI disk imager for raw device copying
    dualsensectl # Control and configure DualSense controller features (Candidate for removal since Steam Input provides majority of functionality.)
    poweralertd # Warn on power loss or battery drop
    wavemon # Show Wi-Fi signal strength and stats in terminal
  ];
}
