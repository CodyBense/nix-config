{ pkgs, ... }:
{
  services.grocy = {
    enable = true;
    hostName = "cody.grocy";
    settings = {
      currency = "USD";
      culture = "en";

      calendar = {
        showWeekNumber = true;
        firstDayOfWeek = 0;
      };
    };
  };

  services.nginx.virtualHosts."cody.grocy".listen = [
    {
      addr = "192.168.1.232";
      port = 9283;
    }
  ];

  security.acme.acceptTerms = true;

  networking.firewall.allowedTCPPorts = [ 9283 ];
}
