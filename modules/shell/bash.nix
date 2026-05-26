{...}: {
  flake = {
    nixosModules.shell.programs.bash = {
      enable = true;
      completion.enable = true;
      blesh.enable = true;
    };
    homeModules.shell.programs.bash = {
      enable = true;
      enableCompletion = true;
      initExtra = ''
        set -o vi
      '';
      shellAliases = {
        ll = "ls -lah";
        ".." = "cd ..";
      };
    };
  };
}
