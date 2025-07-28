{pkgs, ...}: {
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      systemd-boot.configurationLimit = 10;
    };
    supportedFilesystems = ["ntfs"];
    kernel.sysctl = { "vm.max_map_count" = 2147483642; };
  };
}
