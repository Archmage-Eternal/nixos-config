{...}: {
  flake.nixosModules.shell.programs.nushell = {
    enable = true;
    settings.edit_mode = "vi";
  };
}