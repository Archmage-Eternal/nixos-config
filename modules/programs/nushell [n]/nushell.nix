# Nushell (home-manager), vi editing.
{
  flake.modules.homeManager.nushell.programs.nushell = {
    enable = true;
    settings.edit_mode = "vi";
  };
}
