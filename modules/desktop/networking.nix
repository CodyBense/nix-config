{ config, lib, pkgs, ... }:

{
  networking.networkmanager.enable = true;
  services.tailscale.enable = true;
  environment.systemPackages = with pkgs; [
    networkmanager
    networkmanagerapplet
  ];
}
