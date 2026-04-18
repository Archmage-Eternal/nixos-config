{ pkgs, ... }:
{
  programs.git = {
    enable = true;
    signing.format = "openpgp";
    settings = {
      user = {
        name = "Archmage-Eternal";
        email = "davidlobo.dev@gmail.com";
      };
      init = { defaultBranch = "main"; };
      merge = { conflictstyle = "diff3"; };
      diff = { colorMoved = "default"; };
      pull = { ff = "only"; };
      color = { ui = true; };
      url = {
        "git@github.com:".insteadOf = [
          "gh:"
          "https://github.com/"
        ];
      };
    };
  };

  home.packages = [ pkgs.gh ]; # pkgs.git-lfs
}
