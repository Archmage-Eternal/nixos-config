# Polkit authentication agent (home-manager): GUI privilege prompts. Named by
# role so the implementation can be swapped. hyprpolkitagent is a plain Wayland
# client (no Hyprland IPC), but its service rides graphical-session.target,
# which plain mango does not start (see TODO item 9).
{
  flake.modules.homeManager.polkit-agent.services.hyprpolkitagent.enable = true;
}
