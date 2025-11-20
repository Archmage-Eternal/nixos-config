{...}: {
  programs.bash = {
    enable = true;
    enableCompletion = true;
    blesh.enable = true;
    interactiveShellInit = "set -o vi";
    shellAliases = {
      ll = "ls -lah";
      ".." = "cd ..";
    };
  };
}
