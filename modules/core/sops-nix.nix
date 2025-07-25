{inputs, ...}: {
  imports = [
    inputs.sops-nix.nixosModules.sops
  ];

  sops = {
    age.keyFile = "/home/david/.config/sops/age/keys.txt"; # path to private key
    age.generateKey = false;

    defaultSopsFile = ../../secrets/secrets.yaml;

    secrets = {
      "git/personal" = {
        owner = "david";
        mode = "0400";
      };
    };
  };
}
