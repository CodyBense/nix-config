{ ... }:
{
  services.geoather.enable = true;
  networking.firewall.allowedTCPPorts = [ 8000 ];

}
