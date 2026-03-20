{...}: {
  flake = {
    homeModules.dev = {
      pkgs,
      inputs,
      ...
    }: {
      home.packages = with pkgs; [
        cmake
        gcc
        gdb
        gef
        gnumake
        llvmPackages_20.clang-tools
        nixd
        nixfmt-rfc-style
        python3
        python312Packages.ipython
        valgrind
        gh
        inputs.nixCats.packages.${pkgs.stdenv.hostPlatform.system}.default
      ];

      programs = {
        git = {
          enable = true;
          settings = {
            user = {
              name = "Archmage-Eternal";
              email = "davidlobo.dev@gmail.com";
            };
            init = {defaultBranch = "main";};
            merge = {conflictstyle = "diff3";};
            diff = {colorMoved = "default";};
            pull = {ff = "only";};
            color = {ui = true;};
            url = {
              "git@github.com:".insteadOf = [
                "gh:"
                "https://github.com/"
              ];
            };
          };
        };

        lazygit.enable = true;

        delta = {
          enable = true;
          enableGitIntegration = true;
          options = {
            line-numbers = true;
            side-by-side = false;
            diff-so-fancy = true;
            navigate = true;
          };
        };
      };
    };
  };
}
