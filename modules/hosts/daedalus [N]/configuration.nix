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
        nh
        locale
        timezone
        # Fallback: swap `secureboot` for `boot` (import exactly one).
        secureboot
        firmware
        network
        bluetooth
        audio
        upower
        logitech
        nvidia
        asus
        greetd
        hyprland
        mangowm
        gaming-desktop
        theming
        david
      ])
      ++ [
        # host-local hardware (import-tree ignores files prefixed with _)
        ./_disk-config.nix
        ./_nvidia.nix
      ];

    networking.hostName = "daedalus";
    # AMD CPU: load microcode updates (needs the firmware aspect).
    hardware.cpu.amd.updateMicrocode = true;
    system.stateVersion = "26.11";
  };
}
