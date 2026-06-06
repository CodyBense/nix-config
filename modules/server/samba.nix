{ config, lib, pkgs, ... }:

{
  services.samba = {
    package = pkgs.samba4Full;
    usershares.enable = true;
    enable = true;
    openFirewall = true;
  };

  services.samba-wsdd = {
    enable = true;
    openFirewall = true;
  };

  users.users.cody = {
    isNormalUser = true;
    extraGroups = [ "samba" ];
  };
}
