{...}: {
  programs.readline = {
    enable = true;
    variables = {
      "editing-mode" = "vi";
      "show-mode-in-prompt" = "on";
    };
    bindings = {
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
}
