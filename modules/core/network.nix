{ pkgs, host, ... }:
{
  networking = {
    hostName = "${host}";
    networkmanager.enable = true;
    firewall = {
      enable = true;
    };
  };

  environment.systemPackages = with pkgs; [ networkmanagerapplet ];
}
