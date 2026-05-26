{...}: {
  flake = {
    nixosModules.hyprland = {
      inputs,
      pkgs,
      ...
    }: {
      imports = [inputs.hyprland.nixosModules.default];

      xdg.portal.config.hyprland = {
        default = [
          "hyprland"
          "gtk"
        ];
        "org.freedesktop.impl.portal.FileChooser" = ["gtk"];
      };

      programs.hyprland = {
        enable = true;
        withUWSM = true;
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
      };

      # What does this bit do?
      home-manager.sharedModules = [
        inputs.self.homeModules.hyprland
      ];
    };

    homeModules.hyprland = {
      config,
      lib,
      pkgs,
      ...
    }: {
      home.packages = with pkgs; [
        # scripts may be broken
        (pkgs.writeShellScriptBin "hypr-screenshot" (builtins.readFile ../../scripts/hypr-screenshot.sh))
        (pkgs.writeShellScriptBin "hypr-record" (builtins.readFile ../../scripts/hypr-record.sh))
        # Do we need both grim and grimblast?
        grim
        grimblast
        slurp
        wf-recorder
        wl-clipboard
      ];

      wayland.windowManager.hyprland = {
        enable = true;
        package = null;
        portalPackage = null;
      };
    };
  };
}
