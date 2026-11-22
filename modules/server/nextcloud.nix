{ pkgs, ... }:
{
  services.nextcloud = {
    enable = true;
    hostName = "nextcloud.cody.homelab";
    config.adminpassFile = "/etc/nextcloud-admin-pass";
    config.dbtype = "sqlite";
    settings = {
      maintenance_window_start = 1;
      default_phone_region = "US";
      log_type = "systemd";
      serverid = 0;
    };
  };
}
