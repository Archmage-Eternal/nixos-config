{...}: {
  programs.bash = {
    enable = true;
    completion.enable = true;
    blesh.enable = true;
    interactiveShellInit = "set -o vi";
    shellAliases = {
      ll = "ls -lah";
      ".." = "cd ..";
    };
  };
}
