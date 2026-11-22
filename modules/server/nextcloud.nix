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
  services.tailscale.enable = true;

  services.nextcloud = {
    enable = true;
    package = pkgs.nextcloud33;
    hostName = "maul.tail24506c.ts.net";
    https = true;

    database.createLocally = true;
    configureRedis = true;
    maxUploadSize = "16G";

    config.dbtype = "pgsql";

    settings = {
      default_phone_region = "US";
      overwriteprotocol = "https";
    };

    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps) calendar contacts notes;
    };
    extraAppsEnable = true;

    autoUpdateApps.enable = true;
    phpOptions."opcache.interned_strings_buffer" = "16";
  };

  services.nginx.virtualHosts."maul.tail24506c.ts.net" = {
    forceSSL = true;
    sslCertificate = "/var/lib/tailscale-certs/cert.crt";
    sslCertificateKey = "/var/lib/tailscale-certs/cert.key";
  };

  # Fetch/renew the cert weekly (tailscale only renews when it's near expiry)
  systemd.services.tailscale-cert = {
    after = [ "tailscaled.service" ];
    serviceConfig.Type = "oneshot";
    script = ''
      mkdir -p /var/lib/tailscale-certs
      ${pkgs.tailscale}/bin/tailscale cert \
        --cert-file /var/lib/tailscale-certs/cert.crt \
        --key-file /var/lib/tailscale-certs/cert.key \
        maul.tail24506c.ts.net
      chown -R nginx:nginx /var/lib/tailscale-certs
      chmod 600 /var/lib/tailscale-certs/cert.key
      systemctl reload nginx || true
    '';
  };
  systemd.timers.tailscale-cert = {
    wantedBy = [ "timers.target" ];
    timerConfig = {
      OnCalendar = "weekly";
      Persistent = true;
    };
  };

  # Only reachable over Tailscale
  networking.firewall.interfaces.tailscale0.allowedTCPPorts = [
    80
    443
  ];
}
