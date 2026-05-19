{
  configurations.nixos.daedalus.module = {
    networking.hostName = "daedalus";
    nixpkgs.hostPlatform = "x86_64-linux";
  };
}
