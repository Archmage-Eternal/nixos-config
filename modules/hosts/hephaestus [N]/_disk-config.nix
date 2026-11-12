# PLACEHOLDER disk layout (disko). The machine has no OS yet and its disks are
# unknown, so this exists only so the host evaluates. Replace `device` with the
# real /dev/disk/by-id/... and rethink the layout (encryption, data disks)
# before installing. The placeholder device does not exist, so disko fails
# safely if run as is.
{
  disko.devices.disk.main = {
    type = "disk";
    device = "/dev/disk/by-id/PLACEHOLDER-replace-me";
    content = {
      type = "gpt";
      partitions = {
        ESP = {
          size = "512M";
          type = "EF00";
          content = {
            type = "filesystem";
            format = "vfat";
            mountpoint = "/boot";
            mountOptions = ["umask=0077"];
          };
        };
        root = {
          size = "100%";
          content = {
            type = "filesystem";
            format = "ext4";
            mountpoint = "/";
          };
        };
      };
    };
  };
}
