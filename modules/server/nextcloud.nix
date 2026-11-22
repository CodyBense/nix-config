# { pkgs, ... }:
# {
#   services.nextcloud = {
#     package = pkgs.nextcloud35;
#     enable = true;
#     hostName = "nextcloud.cody.homelab";
#     config.dbtype = "sqlite";
#     settings = {
#       maintenance_window_start = 1;
#       default_phone_region = "US";
#       log_type = "systemd";
#       serverid = 0;
#     };
#   };
# }
{ config, pkgs, ... }:

{
  # Admin password file, kept out of the Nix store
  environment.etc."nextcloud-admin-pass".text = "change-me-immediately";
  # Better: use agenix/sops-nix and point adminpassFile at the decrypted secret

  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud31; # required; pick the newest one available (see note below)
    hostName = "nextcloud.cody.homelab";
    https = true; # tells Nextcloud it's behind TLS

    database.createLocally = true;
    configureRedis = true; # local Redis for file locking/caching
    maxUploadSize = "16G";

    config = {
      dbtype = "pgsql";
      adminuser = "admin";
    };

    settings = {
      default_phone_region = "US";
      overwriteprotocol = "https";
    };

    # Optional: declaratively install apps
    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps) calendar contacts notes;
    };
    extraAppsEnable = true;

    autoUpdateApps.enable = true;
    phpOptions."opcache.interned_strings_buffer" = "16";
  };

  # nginx is configured automatically by the module; you just add TLS
  services.nginx.virtualHosts."nextcloud.cody.homelab" = {
    forceSSL = true;
    enableACME = true;
  };

  security.acme = {
    acceptTerms = true;
    defaults.email = "codybense@proton.me";
  };

  networking.firewall.allowedTCPPorts = [
    80
    443
  ];
}
