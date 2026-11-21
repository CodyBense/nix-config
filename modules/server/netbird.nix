{ ... }:
{
  services.netbird.clients.wt0 = {
    login = {
      enable = true;
      setupKeyFile = "/home/cody/Documents/.netbird.homelab.key";
    };

    port = 51820;
    ui.enable = true;
    openFirewall = true;
    openInternalFirewall = true;
  };

}
