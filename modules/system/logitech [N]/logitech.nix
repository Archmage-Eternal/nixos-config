# Logitech devices (NixOS): Solaar (pairing, battery, DPI, button settings for
# Unifying/Bolt receivers and HID++ devices). It also enables the Logitech udev
# rules, so `hardware.logitech.wireless` is not set separately.
{
  flake.modules.nixos.logitech.programs.solaar.enable = true;
}
