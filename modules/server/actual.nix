{
  config,
  lib,
  pkgs,
  ...
}:

{
  # services.actual = {
  #   enable = true;
  #   openFirewall = true;
  #   settings = {
  #     port = 3000;
  #   };
  # };

  networking.firewall.allowedTCPPorts = [ 3000 ];
  services.actual = {
    enable = true;
    openFirewall = true;
    settings = {
      hostname = "0.0.0.0";
      port = 3000;
      dataDir = "/var/lib/actual";
    };
  };

  services.nginx = {
    enable = true;
    virtualHosts."budget.codybense.com" = {
      enableACME = true;
      forceSSL = true;
      locations."/" = {
        proxyPass = "http://127.0.0.1:3000";
        proxyWebsockets = true;
      };
    };
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "codybense@proton.me";
  };
}
