{pkgs, ...}: {
  home.packages = [
    (pkgs.writeShellScriptBin "protonhax" (builtins.readFile ./protonhax.sh))
    (pkgs.writeShellScriptBin "j" (builtins.readFile ./journal.sh))
  ];
}
