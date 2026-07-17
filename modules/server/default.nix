{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./actual.nix
    ./databases.nix
    ./home-assistant/docker-compose.nix
    ./immich.nix
    ./minecraft.nix
    # ./n8n.nix
    ./n8n/docker-compose.nix
    ./nixarr.nix
    ./ollama.nix
    ./pihole/docker-compose.nix
    ./samba.nix
    ./syncthing.nix
    ./tailscale.nix
  ];

  environment.systemPackages = with pkgs; [
    wakeonlan
  ];
}
