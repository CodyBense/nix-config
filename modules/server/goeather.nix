{ ... }:
{
  services.goeather = {
      enable = true;
      port = 8000;
  };
  networking.firewall.allowedTCPPorts = [ 8000 ];

}
