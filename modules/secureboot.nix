{...}: {
  flake.nixosModules.secureboot = {
    lib,
    pkgs,
    inputs,
    ...
  }: {
    imports = [inputs.lanzaboote.nixosModules.lanzaboote];

    boot = {
      initrd.systemd.enable = true;

      loader.systemd-boot.enable = lib.mkForce false;

      lanzaboote = {
        enable = true;
        pkiBundle = "/etc/secureboot";
      };
    };

    environment.systemPackages = [pkgs.sbctl];
  };
}
