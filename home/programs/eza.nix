{...}: {
  programs.eza = {
    enable = true;
    enableBashIntegration = true;
    enableNushellIntegration = true;
    git = false;
    extraOptions = [];
  };
}