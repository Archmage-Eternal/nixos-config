# Boot (NixOS): systemd-boot with a short generation list. Deliberately
# generic: kernel choice, console quiet-ness and extra filesystems are host
# overrides, since desktops and servers want different ones (see daedalus).
# `secureboot` extends this module; hosts import one of the two.
{
  flake.modules.nixos.boot.boot = {
    loader = {
      systemd-boot = {
        enable = true;
        configurationLimit = 4;
      };
      efi.canTouchEfiVariables = true;
    };
    initrd.systemd.enable = true;
  };
}
