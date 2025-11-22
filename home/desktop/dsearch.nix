{ inputs, ... }:  {
  imports = [ inputs.dsearch.homeModules.default ];

  programs.dsearch = {
    enable = true;

    # Put your config here or omit this for dsearch to generate the default config at runtime
    config = {
      # ...
    };
  };
}
