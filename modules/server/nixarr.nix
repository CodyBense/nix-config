{
  config,
  lib,
  pkgs,
  ...
}:

{
  nixarr = {
    enable = true;

    mediaDir = "/data/media";
    stateDir = "/data/media/.state/nixarr";

    vpn = {
      enable = true;
      wgConf = "/data/.secret/wg.conf";
    };

    jellyfin = {
      enable = true;

      expose.https = {
        enable = true;
        domainName = "codybense.jellyfin.com";
        acmeMail = "codybense@proton.me";
      };
    };

    transmission = {
      enable = true;
      vpn.enable = true;
      peerPort = 50000;
    };

    bazarr = {
      enable = true;
      vpn.enable = true;
    };
    lidarr = {
      enable = true;
      vpn.enable = true;
    };
    prowlarr = {
      enable = true;
      vpn.enable = true;
    };
    radarr = {
      enable = true;
      vpn.enable = true;
    };
    readarr = {
      enable = true;
      vpn.enable = true;
    };
    sonarr = {
      enable = true;
      vpn.enable = true;
    };
    jellyseerr.enable = true;
  };
}
