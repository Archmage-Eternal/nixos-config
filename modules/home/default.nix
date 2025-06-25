{ ... }:
{
  imports = [
    ./bat.nix                         # better cat command
    ./browser.nix                     # firefox based browser
    ./btop.nix                        # resouces monitor 
    ./cava.nix                        # audio visualizer
    ./discord.nix                     # discord
    ./fastfetch.nix                   # fetch tool
    ./fzf.nix                         # fuzzy finder
    ./gaming.nix                      # packages related to gaming
    ./ghostty.nix                     # terminal
    ./git.nix                         # version control
    ./gtk.nix                         # gtk theme
    ./hyprland                        # window manager
    ./lazygit.nix
    ./micro.nix                       # nano replacement
    ./nvim.nix                        # neovim editor
    ./packages                        # other packages
    ./retroarch.nix  
    ./rofi.nix                        # launcher
    ./ssh.nix                         # ssh config
    ./swaync/swaync.nix               # notification deamon
    ./waybar                          # status bar
    ./xdg-mimes.nix                   # xdg config
    # Starship prompt
    ./starship.nix
  ];
}
