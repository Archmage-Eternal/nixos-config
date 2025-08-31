{
  inputs,
  config,
  ...
}: {
  sops = {
    age.keyFile = "${config.home.homeDirectory}/.config/sops/age/keys.txt";
    age.generateKey = false;

    defaultSopsFile = ../../secrets/secrets.yaml;

    secrets = {
      "git/Archmage-Eternal" = {};
    };
  };
}
