{inputs, ...}: {
  configurations.nixos.laptop.module = {
    imports = [
      # ./_hardware-configuration.nix
      ./_disk-config.nix
      inputs.self.nixosModules.disko
      inputs.self.nixosModules.core
      inputs.self.nixosModules.network
      inputs.self.nixosModules.audio
      inputs.self.nixosModules.desktop
      inputs.self.nixosModules.shell
      inputs.self.nixosModules.programs
      inputs.self.nixosModules.users
      inputs.self.nixosModules.asus
      inputs.self.nixosModules.services
      inputs.self.nixosModules.security
      inputs.self.nixosModules.secureboot
      inputs.self.nixosModules.gaming
      inputs.self.nixosModules.nvidia
      inputs.self.nixosModules.peripherals
      inputs.self.nixosModules.virtualization
    ];
  };
}
