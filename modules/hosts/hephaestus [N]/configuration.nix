# Host `hephaestus` (NixOS): headless home server (planned: Immich, game
# servers). Minimal scaffold until the machine has an OS and known hardware.
#
# Disk layout is a placeholder in _disk-config.nix (disko).
{inputs, ...}: {
  flake.modules.nixos.hephaestus = {
    imports =
      (with inputs.self.modules.nixos; [
        disko
        allow-unfree
        nix-settings
        locale
        timezone
        boot
        firmware
        openssh
        gaming-server
        smith
      ])
      ++ [
        # host-local hardware (import-tree ignores files prefixed with _)
        ./_disk-config.nix
      ];

    networking.hostName = "hephaestus";
    # Wired DHCP (dhcpcd). Give the machine a fixed lease on the router so its
    # address, and any port forward to it, stays put.
    networking.useDHCP = true;
    # Intel CPU: load microcode updates (needs the firmware aspect). NPU open.
    hardware.cpu.intel.updateMicrocode = true;
    # Must match the release this machine is first installed with.
    system.stateVersion = "26.11";
  };
}
