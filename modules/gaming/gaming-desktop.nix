# Gaming desktop bundle (NixOS + Home-Manager): the interactive gaming set.
# Composes the granular gaming aspects; a future `gaming-server` would compose
# a different subset (no launchers/overlays/HUDs). Hosts import the NixOS half,
# users import the HM half.
{inputs, ...}: {
  flake.modules.nixos.gaming-desktop.imports = with inputs.self.modules.nixos; [
    steam
    # millennium  # TODO: needs npm fetch through a TLS-proxied network; test at home (see TODO 15)
    gamemode
    gamescope
  ];

  flake.modules.homeManager.gaming-desktop.imports = with inputs.self.modules.homeManager; [
    steam
    mangohud
    wine
    prismlauncher
    protonhax
    memory-scanners
  ];
}
