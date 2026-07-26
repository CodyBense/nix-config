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
    N8N_PORT = "5678";
    N8N_HOST = "0.0.0.0";
  };

  networking.firewall.allowedTCPPorts = [ 5678 ];
}
