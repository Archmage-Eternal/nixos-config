{...}: {
  flake.homeModules.shell.programs.nushell = {
    enable = true;
    settings.edit_mode = "vi";
  };
}
