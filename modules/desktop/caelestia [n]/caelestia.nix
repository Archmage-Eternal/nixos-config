# Caelestia shell (home-manager): bar, launcher, notifications, etc. Shell
# only; no CLI and none of the dotfiles. Started by a systemd user service tied
# to the compositor's graphical-session target (hyprland under uwsm provides
# it; plain mango does not, see TODO item 9).
#
# Contributes the launcher toggle to the keybind registry (via the shell's own
# IPC, so it works on any compositor); does not know which key opens it.
{inputs, ...}: {
  flake.modules.homeManager.caelestia = {
    config,
    lib,
    ...
  }: {
    imports = [inputs.caelestia-shell.homeManagerModules.default];
    programs.caelestia.enable = true;
    keybinds.apps.launcher = "${lib.getExe config.programs.caelestia.package} ipc call drawers toggle launcher";
  };
}
