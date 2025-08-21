{pkgs, ...}: {
  home.packages = [
    (pkgs.writeShellScriptBin "daily-note" (builtins.readFile ./daily_note.sh))
  ];
}
