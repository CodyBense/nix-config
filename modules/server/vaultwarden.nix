{
  config,
  lib,
  pkgs,
  ...
}:
{
  services.vaultwarden = {
    enable = true;
    backupDir = "/var/backup/vaultwarden";
    environmentFile = "/var/lib/vaultwarden.env";
    config = {
      DOMAIN = "https://vaultwarden.codybense.com";
      SIGNUPS_ALLOWED = false;

      ROCKET_ADDRESS = "127.0.0.1";
      ROCKET_PORT = 8222;
      ROCKET_LOG = "critical";

      SMTP_HOST = "127.0.0.1";
      SMTP_PORT = 25;
      SMTP_SECURITY = off;

      SMTP_FROM = "admin@vaultwarden.codybense.com";
      SMTP_FROM_NAME = "codybense.com Vaultwarden server";
    };
  };

  services.caddy.virtualHosts."vaultwarden.codybense.com".extraConfig = ''
        encode zstd gzip

    reverse_proxy :${toString config.services.vaultwarden.config.ROCKET_PORT} {
    header_up X Real-IP {remote_host}
    }
  '';
}
