{...}:
{
  imports = [

    ./nixCats.nix
    # ./stylix.nix
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
    # Git configuration and related utilities
    ./git.nix
    # Fuzzy terminal-based Git UI
    ./lazygit.nix
    # Wayland-based dynamic tiling window manager
    ./hyprland
    # Status bar configuration for Wayland (typically with Hyprland)
    ./waybar
    # Application launcher interface
    ./rofi.nix
    # Notification manager
    ./swaync/swaync.nix
    # Terminal emulator configuration
    ./ghostty.nix
    # XDG MIME-type and default app settings
    # ./xdg-mimes.nix
    # Audio visualizer for terminal
    ./cava.nix
    # Retro gaming platform and emulator frontend
    ./retroarch.nix
    # Applications and utilities related to gaming
    ./gaming.nix
    # Discord client integration
    ./nixcord.nix
    # SSH configuration and key management
    ./ssh.nix
    # Firefox-based web browser configuration
    ./browser.nix
    # Graphical applications and utilities
    ./gui.nix
  ];
}

