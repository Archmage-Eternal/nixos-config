{
  username,
  ...
}:
{
    users.users.${username} = {
    isNormalUser = true;
    description = "${username}";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
  };
  nix.settings.allowed-users = [ "${username}" ];
}
