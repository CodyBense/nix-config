{
  config,
  lib,
  pkgs,
  ...
}:

{
  virtualisation.docker = {
    enable = true;
  };

  users.users.cody.extraGroups = [ "docker" ];
}
