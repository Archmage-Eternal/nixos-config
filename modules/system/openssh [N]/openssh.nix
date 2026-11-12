# OpenSSH server (NixOS): key-only login, no root login. Opens port 22 in the
# firewall (the module default). Authorised keys belong to the user aspects.
{
  flake.modules.nixos.openssh.services.openssh = {
    enable = true;
    settings = {
      PasswordAuthentication = false;
      KbdInteractiveAuthentication = false;
      PermitRootLogin = "no";
    };
  };
}
