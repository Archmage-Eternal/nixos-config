# Redistributable firmware (NixOS): Wi-Fi, Bluetooth, GPU blobs.
{
  flake.modules.nixos.firmware.hardware.enableRedistributableFirmware = true;
}
