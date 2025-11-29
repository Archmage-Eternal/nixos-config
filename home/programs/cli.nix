{pkgs, ...}: {
  home.packages = with pkgs; [
  # CLI Replacements moved to individual program files

    # General CLI Utilities
    aria2
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
    trash-cli
    w3m
    wget # Wget-based download utility
    xdg-utils # Open files/URLs using desktop defaults

    # Development & Diagnostic Tools
    bitwise # Visual interactive bit calculator
    ffmpeg # FFmpeg CLI for media conversion and processing
    mimeo # Copy/paste URL and open with default handler

    # Media & Visual Tools
    ani-cli # Stream and search anime from terminal
    swappy # CLI PDF/image annotation utility
    tdf # PDF viewer for terminal (lightweight)

    # Productivity
    nb # CLI note-taking and knowledge management system

    # CLI Screensavers & Visual Toys
    cbonsai # ASCII bonsai tree animation
    cmatrix # Matrix-style rain animation
    pipes # Animated pipe drawings
    tty-clock # ASCII digital clock for the terminal

    # System Alerting / Power
    caligula # TUI disk imager for raw device copying
    dualsensectl # Control and configure DualSense controller features (Candidate for removal since Steam Input provides majority of functionality.)
    wavemon # Show Wi-Fi signal strength and stats in terminal

    poweralertd # Warn on power loss or battery drop; Has a daemon services.poweralertd.enable
    playerctl # Media key control for MPRIS-compatible players; Has a daemon services.playerctl.d.enable
  ];
}
