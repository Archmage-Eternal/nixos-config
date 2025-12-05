{pkgs, ...}: {
  home.packages = [
    (pkgs.writeShellScriptBin "daily-note" (builtins.readFile ./daily_note.sh))
    (pkgs.writeShellScriptBin "protonhax" (builtins.readFile ./protonhax.sh))
  ];
}
