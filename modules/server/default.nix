{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ./docker.nix
    ./immich.nix
    ./minecraft.nix
    ./nixarr.nix
    ./pihole.nix
    ./tailscale.nix
  ];
}
