{pkgs, ...}: {
  home.packages = with pkgs; [
    # Wayland screenshot / selection
    grim
    slurp

    # Screen recording
    wf-recorder

    # Clipboard helpers / managers
    wl-clipboard

    # Utilities often useful for desktop workflows
    grimblast
  ];
}
