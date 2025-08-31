{pkgs, ...}: {
  services.udev.packages = [pkgs.steam-devices-udev-rules];
}
