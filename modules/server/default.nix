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
    ./docker.nix
    ./immich.nix
    ./minecraft.nix
    ./nixarr.nix
    ./ollama.nix
    # ./pihole.nix
    ./samba.nix
    ./tailscale.nix
  ];

  environment.systemPackages = with pkgs; [
    wakeonlan
  ];
}
