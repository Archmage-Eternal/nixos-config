# Bluetooth (NixOS): bluez stack. `hardware.bluetooth.enable` already puts
# bluetoothctl on PATH.
{
  flake.modules.nixos.bluetooth.hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
}
