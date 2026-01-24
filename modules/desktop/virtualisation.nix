{
  config,
  lib,
  pkgs,
  ...
}:

{
  virtualisation.virtualbox.enable = true;
  users.extraGroup.vboxusers.memebers = [ "cody" ];
}
