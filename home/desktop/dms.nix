{inputs, ...}: {
  imports = [
    inputs.dankMaterialShell.homeModules.dank-material-shell
    inputs.dankMaterialShell.homeModules.niri
  ];

  programs.dank-material-shell = {
    enable = true;

    systemd = { 
      enable = true;
      restartIfChanged = true;
    };

    enableSystemMonitoring = true;
    enableVPN = false;                  # VPN management widget
    enableDynamicTheming = false;       # Wallpaper-based theming (matugen)
    enableAudioWavelength = true;      # Audio visualizer (cava)
    enableCalendarEvents = true;       # Calendar integration (khal)

    default.settings = {
      theme = "dark";
    };

    niri = {
      enableKeybinds = false;
      enableSpawn = false;
    };
  };
}
