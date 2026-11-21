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

<<<<<<< HEAD
  services.nginx.virtualHosts."cody.grocy".listen = [{port=9283}];

=======
>>>>>>> 474b979 (updated grocy)
  security.acme.acceptTerms = true;
}
