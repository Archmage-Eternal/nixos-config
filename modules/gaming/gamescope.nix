# Gamescope (NixOS).
{
  flake.modules.nixos.gamescope.programs.gamescope = {
    enable = true;
    capSysNice = true;
    args = ["--rt" "--expose-wayland"];
  };
}
