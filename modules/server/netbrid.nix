{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.netbird.clients = {
    enable = true;
    port = 51821;
    ui.enable = true;
    openFirewall = true;
    openInternalFirewall = true;
    useRoutingFeatures = "both";
  };
}
