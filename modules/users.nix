{config, ...}: let
  username = config.meta.username;
in {
  flake = {
    nixosModules.users = {inputs, ...}: {
      imports = [inputs.home-manager.nixosModules.home-manager];

      users.users.${username} = {
        isNormalUser = true;
        description = username;
        extraGroups = [
          "networkmanager"
          "wheel"
        ];
      };

      nix.settings.allowed-users = [username];

      home-manager = {
        useUserPackages = true;
        useGlobalPkgs = true;
        extraSpecialArgs = {inherit inputs username;}; # username closed over from flake-parts config
        backupFileExtension = "backup";
        # homeModules.dev has no nixos counterpart to add it via sharedModules,
        # so it is wired in here alongside the core user settings.
        sharedModules = [inputs.self.homeModules.dev];
        users.${username} = {
          home.username = username;
          home.homeDirectory = "/home/${username}";
          home.stateVersion = "24.05";
          programs.home-manager.enable = true;
        };
      };
    };
  };
}
