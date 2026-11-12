# ble.sh (home-manager), part of the bash aspect: replaces readline as bash's
# prompt line editor (syntax highlighting, auto-suggestions, menu completion, a
# fuller vim mode). It imports the readline settings from bash.nix (vi mode,
# key bindings, mode strings), so those stay.
#
# Loaded the way ble.sh documents: sourced at the top of .bashrc without
# attaching, attached at the very end. The top matters because starship (order
# 1900) and ghostty check BLE_VERSION while they initialise.
{
  flake.modules.homeManager.bash = {
    lib,
    pkgs,
    ...
  }: {
    programs.bash = {
      bashrcExtra = lib.mkBefore ''
        [[ $- == *i* ]] && source -- ${pkgs.blesh}/share/blesh/ble.sh --attach=none
      '';
      initExtra = lib.mkOrder 2000 ''
        [[ ! ''${BLE_VERSION-} ]] || ble-attach
      '';
    };
  };
}
