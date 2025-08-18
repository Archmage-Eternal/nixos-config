{ pkgs, username, ... }:
{
  programs.git = {
    enable = true;

    userName = "Archmage-Eternal";
    userEmail = "davidlobo.dev@gmail.com";

    extraConfig = {
      init.defaultBranch = "main";
      merge.conflictstyle = "diff3";
      diff.colorMoved = "default";
      pull.ff = "only";
      color.ui = true;
      url = {
        "git@github.com:".insteadOf = [
          "gh:"
          "https://github.com/"
        ];
      };
    };

    delta = {
      enable = true;
      options = {
        line-numbers = true;
        side-by-side = false;
        diff-so-fancy = true;
        navigate = true;
      };
    };
  };
  home.packages = [ pkgs.gh ]; # pkgs.git-lfs
}
