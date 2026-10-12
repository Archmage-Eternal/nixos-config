# Terminal emulator (home-manager). Contributes a command to the keybind
# registry; does not know or care which key launches it.
{
  flake.modules.homeManager.terminal = {
    programs.ghostty.enable = true;

    keybinds.apps.terminal = "ghostty";
  };
}
