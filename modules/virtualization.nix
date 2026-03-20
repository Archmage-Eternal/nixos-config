{config, ...}: let
  username = config.meta.username;
in {
  flake = {
    nixosModules.virtualization = {pkgs, ...}: {
      users.users.${username}.extraGroups = ["libvirtd"];

      environment.systemPackages = with pkgs; [
        virt-manager
        virt-viewer
        spice
        spice-gtk
        spice-protocol
        virtio-win
        win-spice
        adwaita-icon-theme
      ];

      virtualisation = {
        libvirtd = {
          enable = true;
          qemu.swtpm.enable = true;
        };
        spiceUSBRedirection.enable = true;
        podman = {
          enable = true;
          dockerCompat = true;
        };
        waydroid.enable = true;
      };

      services.spice-vdagentd.enable = true;
    };
  };
}
