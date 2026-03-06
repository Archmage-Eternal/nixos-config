{pkgs, ...}: {
  home.packages = [
    (pkgs.writeShellScriptBin "protonhax" (builtins.readFile ./protonhax.sh))
    (pkgs.writeShellScriptBin "j" (builtins.readFile ./journal.sh))
    (pkgs.writeShellScriptBin "z" (builtins.readFile ./zettelkasten.sh))
    (pkgs.writeShellScriptBin "l" (builtins.readFile ./lists.sh))
  ];
}
