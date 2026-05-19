{...}: let
  secretsFile = ../secrets/secrets.yaml;
in {
  flake = {
    nixosModules.security = {inputs, ...}: {
      imports = [inputs.sops-nix.nixosModules.sops];

      sops.defaultSopsFile = secretsFile;

      home-manager.sharedModules = [
        inputs.sops-nix.homeManagerModules.sops
        inputs.self.homeModules.security
      ];
    };

    homeModules.security = {config, ...}: {
      sops = {
        age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
        age.generateKey = false;

        defaultSopsFile = secretsFile;

        secrets = {
          "git/Archmage-Eternal" = {};
        };
      };
    };
  };
}
