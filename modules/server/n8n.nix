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
    environment = {
      N8N_PORT = "5678";
      N8N_HOST = "0.0.0.0";
      N8N_SECURE_COOKIE = false;
    };
  };

  systemd.services.n8n.path = [ pkgs.nodejs ];

  networking.firewall.allowedTCPPorts = [ 5678 ];
}
