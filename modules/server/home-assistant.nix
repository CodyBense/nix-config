{
  pkgs,
  lib,
  config,
  ...
}:
{
  services.home-assistant = {
    enable = true;
    config = null;
    lovelaceConfig = null;
    configDir = "/etc/home-assistant";
    extraComponents = [
      "analytics"
      "google_translate"
      "met"
      "radio_browser"
      "default_config"
      "esphome"
      "my"
      "shopping_list"
      "wled"
      "isal"
    ];
  };

  networking.firewall.allowedTCPPorts = [ config.services.home-assistant.config.http.server_port ];
}
