{...}: {
programs = {
    dconf.enable = true;
    nix-ld = {
      enable = true;
      libraries = [ ];
    };
  };
}
