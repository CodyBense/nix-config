{
  config,
  lib,
  pkgs,
  ...
}:
let
  HOME = "/home/cody";
in

{
  services.immich = {
    enable = true;
    port = 2283;
    mediaLocation = "${HOME}/Photos/immich";
    host = "0.0.0.0";
    openFirewall = true;
  };
}
