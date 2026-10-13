# Host `daedalus` (NixOS). Composes the feature aspects for this machine.
#
# fileSystems/boot.loader below are placeholders to satisfy nixosSystem
# assertions; real hardware config is out of scope for this bootstrap.
{inputs, ...}: {
  flake.modules.nixos.daedalus = {
    imports = with inputs.self.modules.nixos; [
      home-manager
      hyprland
      david
    ];

    networking.hostName = "daedalus";
    nixpkgs.hostPlatform = "x86_64-linux";
    system.stateVersion = "24.05";

    fileSystems."/" = {
      device = "/dev/disk/by-label/nixos";
      fsType = "ext4";
    };
    boot.loader.grub.device = "nodev";
  };
}
