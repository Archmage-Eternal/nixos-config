{...}:
{
  imports = [

    ./nixCats.nix
    # ──────────────── CLI ENHANCEMENTS ────────────────

    # Improved 'cat' command with syntax highlighting and paging
    ./bat.nix

    # Interactive fuzzy finder for terminal usage
    ./fzf.nix

    # System resource monitor with a TUI interface
    ./btop.nix

    # Terminal fetch tool for displaying system info
    ./fastfetch.nix

    # Minimal terminal-based text editor (nano alternative)
    ./micro.nix

    # CLI customization using Starship prompt
    ./starship.nix

    # Developer tools and language-specific utilities
    ./dev.nix

    # Core command-line applications and utilities
    ./cli.nix

    # ──────────────── VERSION CONTROL ────────────────

    # Git configuration and related utilities
    ./git.nix

    # Fuzzy terminal-based Git UI
    ./lazygit.nix


    # ──────────────── WINDOWING & DESKTOP ────────────────

    # Wayland-based dynamic tiling window manager
    ./hyprland

    # Status bar configuration for Wayland (typically with Hyprland)
    ./waybar

    # Application launcher interface
    ./rofi.nix

    # Notification manager
    ./swaync/swaync.nix

    # GTK theme and icon configuration
    ./gtk.nix

    # Terminal emulator configuration
    ./ghostty.nix

    # XDG MIME-type and default app settings
    ./xdg-mimes.nix

    # ──────────────── MULTIMEDIA ────────────────

    # Audio visualizer for terminal
    ./cava.nix

    # Retro gaming platform and emulator frontend
    ./retroarch.nix

    # Applications and utilities related to gaming
    ./gaming.nix

    # ──────────────── COMMUNICATION ────────────────

    # Discord client integration
    ./discord.nix

    # ──────────────── NETWORKING & REMOTE ACCESS ────────────────

    # SSH configuration and key management
    ./ssh.nix

    # ──────────────── WEB ────────────────

    # Firefox-based web browser configuration
    ./browser.nix

    # ──────────────── GUI APPLICATIONS ────────────────

    # Graphical applications and utilities
    ./gui.nix

  ];
}

