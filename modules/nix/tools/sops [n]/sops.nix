# sops-nix secrets (home-manager only: no system-level secrets yet).
#
# Decrypts secrets/secrets.yaml at login (systemd user service `sops-nix`)
# into $XDG_RUNTIME_DIR/secrets.d. Features declare their own secrets next to
# their consumer. Bootstrap + usage: docs/secrets.md.
{inputs, ...}: {
  flake.modules.homeManager.sops = {config, ...}: {
    imports = [inputs.sops-nix.homeManagerModules.sops];

    sops = {
      # Same path the sops CLI defaults to. Key must have no passphrase.
      age.keyFile = "${config.xdg.configHome}/sops/age/keys.txt";
      # self-relative so this file can move without breaking the path.
      defaultSopsFile = inputs.self + "/secrets/secrets.yaml";
    };
  };

  # `sops` CLI lives in the dev shell: it only works inside this repo anyway
  # (it finds .sops.yaml relative to the file path).
  perSystem = {pkgs, ...}: {
    devshell.packages = [pkgs.sops];
  };
}
