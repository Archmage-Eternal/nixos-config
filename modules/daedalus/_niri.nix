{
  home-manager.sharedModules = [
    {
      programs.niri.settings.outputs."Sharp Corporation LQ156M1JW25 Unknown" = {
        mode = {
          width = 1920;
          height = 1080;
          refresh = 60.005;
        };
        variable-refresh-rate = true;
      };
    }
  ];
}