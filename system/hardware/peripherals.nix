{pkgs, ...}: {
  hardware = {
    logitech.wireless = {
      enable = true;
      enableGraphical = true;
    };

    keyboard.qmk.enable = true;
  };

  services.ratbagd.enable = true;
}
