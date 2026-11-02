# Login manager (NixOS): greetd + tuigreet. Sessions come from the system
# session files (stock menu); no autologin. The greeter runs as the
# unprivileged `greeter` user that the greetd module provides by default.
{
  flake.modules.nixos.greetd = {pkgs, ...}: {
    services.greetd = {
      enable = true;
      # tuigreet is a TUI: keeps systemd unit output off its TTY.
      useTextGreeter = true;
      settings.default_session.command = "${pkgs.tuigreet}/bin/tuigreet --time --remember --remember-session";
    };
  };
}
