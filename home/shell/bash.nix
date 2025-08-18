{...}: {
  programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
      ll = "ls -lah";
      ".." = "cd ..";
    };
  };
}
