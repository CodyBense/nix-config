{
  config,
  inputs,
  pkgs,
  ...
}:
{
  services.n8n = {
    enable = true;
    openFirewall = true;
  };
  environment = {
    GENERIC_TIMEZONE = config.time.timeZone;
  };

  networking.firewall.allowedTCPPorts = [ 5678 ];
}
