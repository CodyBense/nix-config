{ pkgs, ... }:
{
  services.nextcloud = {
    package = pkgs.nextcloud35;
    enable = true;
    hostName = "nextcloud.cody.homelab";
    config.dbtype = "sqlite";
    settings = {
      maintenance_window_start = 1;
      default_phone_region = "US";
      log_type = "systemd";
      serverid = 0;
    };
  };
}
