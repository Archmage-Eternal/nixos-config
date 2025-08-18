{pkgs, ...}: {
  boot = {
    kernelPackages = pkgs.linuxPackages_zen;
    kernel.sysctl = {"vm.max_map_count" = 2147483642;};
    loader = {
      systemd-boot.enable = true;
      efi.canTouchEfiVariables = true;
      systemd-boot.configurationLimit = 10;
    };
    supportedFilesystems = ["ntfs"];
  };
}
