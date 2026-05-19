{...}: {
  flake = {
    nixosModules.nvidia = {config, ...}: {
      services.xserver.videoDrivers = ["nvidia"];

      hardware = {
        graphics = {
          enable = true;
          enable32Bit = true;
        };

        nvidia = {
          modesetting.enable = true;

          powerManagement = {
            enable = true;
            finegrained = true;
          };

          open = true;

          nvidiaSettings = true;

          package = config.boot.kernelPackages.nvidiaPackages.stable;

          prime = {
            offload = {
              enable = true;
              enableOffloadCmd = true;
            };
          };
        };
      };
    };
  };
}
