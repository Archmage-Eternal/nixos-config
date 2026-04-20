{
  configurations.nixos.laptop.module = {
    networking.hostName = "laptop";
    nixpkgs.hostPlatform = "x86_64-linux";
  };
}
