# Host `daedalus` (NixOS). Composes the feature aspects for this machine.
#
# Disk layout lives in _disk-config.nix (disko); it provides fileSystems.*.
# boot.loader.grub is a placeholder until real hardware config lands.
{inputs, ...}: {
  flake.modules.nixos.daedalus = {
    imports =
      (with inputs.self.modules.nixos; [
        home-manager
        disko
        allow-unfree
        nvidia
        hyprland
        mangowm
        david
      ])
      ++ [
        # host-local hardware (import-tree ignores files prefixed with _)
        ./_disk-config.nix
        ./_nvidia.nix
      ];

    networking.hostName = "daedalus";
    nixpkgs.hostPlatform = "x86_64-linux";
    system.stateVersion = "26.11";

    # disko derives fileSystems.* from _disk-config.nix; boot.loader still
    # needs a real bootloader once hardware config lands.
    boot.loader.grub.device = "nodev";
  };
}
