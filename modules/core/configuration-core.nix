{ pkgs, inputs, ... }:

{
  ### ---- Nix System Configuration ---- ###
  nix = {
    settings = {
      auto-optimise-store = true;
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [
        "https://nix-community.cachix.org"
        "https://nix-gaming.cachix.org"
        "https://hyprland.cachix.org"
        "https://ghostty.cachix.org"
      ];
      trusted-public-keys = [
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
        "nix-gaming.cachix.org-1:nbjlureqMbRAxR1gJ/f3hxemL9svXaZF/Ees8vCUUs4="
        "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc="
        "ghostty.cachix.org-1:QB389yTa6gTyneehvqG58y0WnHjQOqgnA+wBnpWWxns="
      ];
    };
  };

  nixpkgs = {
    overlays = [ inputs.nur.overlays.default ];
    config.allowUnfree = true;
  };

  ### ---- System Environment ---- ###
  environment.systemPackages = with pkgs; [
    wget
    git
  ];

  time.timeZone = "Asia/Kolkata";
  i18n.defaultLocale = "en_US.UTF-8";
  system.stateVersion = "24.05";

  ### ---- Programs ---- ###
  programs = {
    dconf.enable = true;
    nix-ld = {
      enable = true;
      libraries = with pkgs; [ ];
    };
  };
}

