{...}: {
  flake = {
    nixosModules.shell = {inputs, ...}: {
      programs.bash = {
        enable = true;
        completion.enable = true;
        blesh.enable = true;
        interactiveShellInit = "set -o vi";
        shellAliases = {
          ".." = "cd ..";
        };
      };

      home-manager.sharedModules = [inputs.self.homeModules.shell];
    };

    homeModules.shell = {
      inputs,
      config,
      ...
    }: {
      imports = [inputs.self.homeModules.starship];

      programs = {
        bash = {
          enable = true;
          enableCompletion = true;
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

        nushell = {
          enable = true;
          settings.edit_mode = "vi";
        };

        zoxide = {
          enable = true;
          enableBashIntegration = true;
          enableNushellIntegration = true;
          options = ["--cmd cd"];
        };

        ssh = {
          enable = true;
          enableDefaultConfig = false;
          matchBlocks = {
            "*" = {
              addKeysToAgent = "1h";
              controlMaster = "auto";
              controlPath = "${config.home.homeDirectory}/.ssh/control-%r@%h:%p";
              controlPersist = "10m";
            };
            github = {
              host = "github.com";
              hostname = "ssh.github.com";
              user = "git";
              port = 443;
              identityFile = "${config.sops.secrets."git/Archmage-Eternal".path}";
              identitiesOnly = true;
            };
          };
        };
      };

      services.ssh-agent.enable = true;
    };
  };
}
