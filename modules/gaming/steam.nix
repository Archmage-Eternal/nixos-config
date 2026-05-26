{...}: { 
  flake.nixosModules.gaming = { inputs, pkgs, ... }: {
    nixpkgs.overlays = [inputs.millennium.overlays.default];
    programs.steam = {
      enable = true;
      # package = pkgs.millennium-steam;
      remotePlay.openFirewall = true;
      dedicatedServer.openFirewall = false;
      protontricks.enable = true;
      gamescopeSession.enable = true;
      extraCompatPackages = [pkgs.proton-ge-bin];
    };
  };
}