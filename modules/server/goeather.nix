{ ... }:
{
  services.goeather.enable = true;
  networking.firewall.allowedTCPPorts = [ 8000 ];

}
