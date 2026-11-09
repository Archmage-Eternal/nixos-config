# ASUS laptop support (NixOS): asusd (asusctl: fan/keyboard/platform profile)
# and supergfxd (supergfxctl: GPU mode switching). Pairs with `nvidia`.
{
  flake.modules.nixos.asus.services = {
    asusd.enable = true;
    supergfxd.enable = true;
  };
}
