{pkgs, ...}: {
  environment = {
    systemPackages = with pkgs; [
      egl-wayland
    ];
    sessionVariables = {
      NIXOS_OZONE_WL = "1";
      LIBVA_DRIVER_NAME = "nvidia";
      __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    };
  };
}
