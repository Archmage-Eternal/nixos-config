# Gaming server bundle (NixOS): what a headless game-hosting machine needs.
# Just steamcmd for now; design to follow (per-game services, firewall, users).
# The desktop counterpart is `gaming-desktop`.
{inputs, ...}: {
  flake.modules.nixos.gaming-server.imports = with inputs.self.modules.nixos; [
    steamcmd
  ];
}
