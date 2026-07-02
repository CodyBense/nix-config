{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    guiAddress = "192.168.1.232:8384";
    user = "cody";
    group = "users";
  };

  networking.firewall.allowedTCPPorts = [ 8384 ];
}
