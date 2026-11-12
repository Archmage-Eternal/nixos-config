# User `smith` (NixOS): the administrator account for headless servers. No
# home-manager bundle (a lean one is TODO item 4). Login is by SSH key only (see
# the `openssh` aspect), so the key goes below. sudo asks for a password: set
# one at install time with `passwd smith`.
{
  flake.modules.nixos.smith = {
    users.users.smith = {
      isNormalUser = true;
      description = "smith";
      extraGroups = ["wheel"];
      # TODO: add the public key(s) allowed to log in, before the first install.
      openssh.authorizedKeys.keys = [];
    };
    nix.settings.allowed-users = ["smith"];
  };
}
