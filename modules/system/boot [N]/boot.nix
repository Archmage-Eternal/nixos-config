# Boot (NixOS). systemd-boot, zen kernel, quiet console.
# `secureboot` extends this module; hosts import one of the two.
{
  flake.modules.nixos.boot = {pkgs, ...}: {
    boot = {
      loader = {
        systemd-boot = {
          enable = true;
          configurationLimit = 4;
        };
        efi.canTouchEfiVariables = true;
      };
      initrd = {
        systemd.enable = true;
        verbose = false;
      };
      kernelPackages = pkgs.linuxPackages_zen;
      kernel.sysctl."vm.max_map_count" = 2147483642; # gaming
      supportedFilesystems = ["ntfs"];
      # Keep kernel/initrd text off the tuigreet TTY. Still in `journalctl -b`.
      # Level 0 still prints emergency messages, so a panic stays visible.
      consoleLogLevel = 0;
    };
  };
}
