# Host `daedalus` (NixOS). Composes the feature aspects for this machine.
#
# Disk layout lives in _disk-config.nix (disko); it provides fileSystems.*.
{inputs, ...}: {
  flake.modules.nixos.daedalus = {
    imports =
      (with inputs.self.modules.nixos; [
        home-manager
        disko
        allow-unfree
        nix-settings
        locale
        timezone
        # Fallback: swap `secureboot` for `boot` (import exactly one).
        secureboot
        nvidia
        greetd
        hyprland
        mangowm
        gaming-desktop
        dconf
        theming
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
  };
}
