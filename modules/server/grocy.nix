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

  security.acme.acceptTerms = true;
}
