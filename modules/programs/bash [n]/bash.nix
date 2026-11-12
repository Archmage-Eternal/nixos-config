# Bash (home-manager), with readline configured here since readline is bash's
# line editor. Vi editing, with a cursor-shape mode indicator in the prompt.
{
  flake.modules.homeManager.bash.programs = {
    bash = {
      enable = true;
      shellAliases = {
        ll = "ls -lah";
        ".." = "cd ..";
      };
    };

    readline = {
      enable = true;
      variables = {
        "editing-mode" = "vi";
        "show-mode-in-prompt" = "on";
      };
      bindings = {
        # vi-insert maps C-l to self-insert, so clear-screen needs binding.
        "\\C-l" = "clear-screen";
        "\\C-x\\C-e" = "edit-and-execute-command";
      };
      extraConfig = ''
        set vi-ins-mode-string "\1\e[6 q\2"
        set vi-cmd-mode-string "\1\e[2 q\2"
        $if mode=vi
          "\C-p": history-search-backward
          "\C-n": history-search-forward
        $endif
      '';
    };

    # Ghostty's bash integration breaks readline's show-mode-in-prompt (the
    # indicator lands on the previous line; ghostty-org/ghostty#10953), so it is
    # off while the indicator is on. The legacy config did the same. TODO 23.
    ghostty.enableBashIntegration = false;
  };
}
