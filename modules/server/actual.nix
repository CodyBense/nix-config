{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.actual = {
    enable = true;
    openFirewall = true;
    settings = {
      port = 3000;
    };
  };
  networking.firewall.allowedTCPPorts = [ 3000 ];
}
