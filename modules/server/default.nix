{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./databases.nix
    ./docker.nix
    ./immich.nix
    ./minecraft.nix
    ./nixarr.nix
    # ./ollama.nix
    # ./pihole.nix
    # ./rssfeed.nix
    ./tailscale.nix
  ];

  environment.systemPackages = with pkgs; [
    wakeonlan
  ];
}
