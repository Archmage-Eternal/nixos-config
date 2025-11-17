{inputs, ...}: {
  imports = [inputs.nix-flatpak.nixosModules.nix-flatpak];

  services.flatpak = {
    enable = false;
    packages = [
      # "com.github.tchx84.Flatseal" #Manage flatpak permissions - should always have this
      # "com.rtosta.zapzap" # WhatsApp client
      #"io.github.flattool.Warehouse"   # Manage flatpaks, clean data, remove flatpaks and deps
      #"it.mijorus.gearlever"           # Manage and support AppImages
      #"io.github.dvlv.boxbuddyrs"      #  Manage distroboxes
    ];
    update.onActivation = true;
  };
}
