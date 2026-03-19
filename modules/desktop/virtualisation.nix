{
  config,
  lib,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [
    winboat
  ];

  virtualisation.docker.enable = true;
  users.users.cody.extraGroup = [ "docker" ];
  virtualisation.virtualbox.host.enable = true;
  users.extraGroups.vboxusers.members = [ "cody" ];
}
