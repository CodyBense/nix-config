{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.freshrss = {
    enable = true;
    virtualHost = "freshrss.cody.com";
    baseUrl = "https://freshrss.cody.com";
    webserver = "nginx";
    defaultUser = "cody";
    passwordFile = "~/Documents/freshrss/";
  };

  services.postgresql = {
    enable = true;
    ensureDatabases = [ "freshrss" ];
    ensureUsers = [
      {
        name = "freshrss";
        ensureDBOwnership = true;
      }
    ];
  };

  services.nginx.virtualHosts = {
    "freshrss.cody.com" = {
      forceSSL = true;
      enableACME = true;
    };
  };
}
