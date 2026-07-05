{
  pkgs,
  lib,
  config,
  ...
}:
{
  # services.home-assistant = {
  #   enable = true;
  #   config = null;
  #   lovelaceConfig = null;
  #   configDir = "/etc/home-assistant";
  #   extraComponents = [
  #     "analytics"
  #     "google_translate"
  #     "met"
  #     "radio_browser"
  #     "default_config"
  #     "esphome"
  #     "my"
  #     "shopping_list"
  #     "wled"
  #     "isal"
  #   ];
  # };

services.home-assistant = {
    enable = true;
    extraComponents = [
      # Components required to complete the onboarding
      "analytics"
      "google_translate"
      "met"
      "radio_browser"
      "shopping_list"
      # Recommended for fast zlib compression
      # https://www.home-assistant.io/integrations/isal
      "isal"
    ];
    config = {
      # Includes dependencies for a basic setup
      # https://www.home-assistant.io/integrations/default_config/
      default_config = {};
    };
  };

  networking.firewall.allowedTCPPorts = [ 8123 ];
}
