# User `david` — NixOS side. Creates the system user and attaches the
# home-manager bundle. Home-manager itself is wired by nixos.home-manager,
# which the host imports.
{inputs, ...}: {
  flake.modules.nixos.david = {inputs, ...}: {
    users.users.david = {
      isNormalUser = true;
      description = "david";
      extraGroups = ["networkmanager" "wheel"];
    };

    nix.settings.allowed-users = ["david"];

    home-manager = {
      extraSpecialArgs = {inherit inputs;};
      users.david = {
        imports = [inputs.self.modules.homeManager.david];
        home.username = "david";
        home.homeDirectory = "/home/david";
        home.stateVersion = "24.05";
        programs.home-manager.enable = true;
      };
    };
  };
}
