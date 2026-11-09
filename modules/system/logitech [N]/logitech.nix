# Logitech devices (NixOS).
# - Solaar: pairing, battery and HID++ settings for Lightspeed/Unifying/Bolt
#   receivers. It also enables the Logitech udev rules, so
#   `hardware.logitech.wireless` is not set separately.
# - ratbagd + Piper: onboard settings (DPI, buttons, report rate) for the G Pro
#   X Superlight. ratbagd is D-Bus activated, so it only runs while Piper is
#   open. Plug the mouse in with the cable to configure it; the settings are
#   stored on the mouse.
{
  flake.modules.nixos.logitech = {pkgs, ...}: {
    programs.solaar.enable = true;
    services.ratbagd.enable = true;
    environment.systemPackages = [pkgs.piper];
  };
}
