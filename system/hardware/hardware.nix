{...}: {
  hardware = {
    enableRedistributableFirmware = true;

    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };

    logitech.wireless = {
      enable = true;
      enableGraphical = true;
    };

    keyboard.qmk.enable = true;
  };
}
