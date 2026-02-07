{
  config,
  lib,
  pkgs,
  ...
}:
let
  HOME = "/home/codybense";
in

{
  services.immich = {
    enable = true;
    port = 2283;
    mediaLocation = "${HOME}/Photos/immich";
  };
}
