{ ... }:
{
  services.netbird.clients.wt0 = {
    # login = {
    #   enable = true;
    #   setupKeyFile = "/run/secrets/netbird-priv/setup-key";
    # };

    port = 51820;
    ui.enable = true;
    openFirewall = true;
    openInternalFirewall = true;
  };

}
