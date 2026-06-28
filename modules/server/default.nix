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
    # ./docker.nix
    ./home-assistant.nix
    ./immich.nix
    ./minecraft.nix
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
