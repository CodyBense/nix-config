{ pkgs, ... }:
{
  services.grocy = {
    enable = true;
    hostName = "grocy.cody.homelab";
  };
}
