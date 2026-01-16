{ config, lib, pkgs, ... }:

{
  services.udisks2.enable = true;

  systemd.services.udisks2 = {
    wantedBy = ["graphical-session.target"];
  };

  environment.systemPackages = with pkgs; [
    udisks2
    udiskie
  ];
}
