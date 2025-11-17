{inputs, ...}: {
  imports = [
    inputs.dankMaterialShell.homeModules.dankMaterialShell.default
    inputs.dankMaterialShell.homeModules.dankMaterialShell.niri
  ];

  programs.dankMaterialShell = {
    enable = true;

    systemd = { 
      enable = true;
      restartIfChanged = true;
    };

    enableSystemMonitoring = true;
    enableClipboard = true;            # Clipboard history manager
    enableVPN = false;                  # VPN management widget
    enableBrightnessControl = true;    # Backlight/brightness controls
    enableColorPicker = true;          # Color picker tool
    enableDynamicTheming = false;       # Wallpaper-based theming (matugen)
    enableAudioWavelength = true;      # Audio visualizer (cava)
    enableCalendarEvents = true;       # Calendar integration (khal)
    enableSystemSound = true;          # System sound effects

    default.settings = {
      theme = "dark";
    };

    niri = {
      enableKeybinds = true;
      enableSpawn = true;
    };
  };
}
