{
  config,
  lib,
  pkgs,
  ...
}:

{
  environment.systemPackages = with pkgs; [ cifs-utils ];

  imports = [
    ./mounts.nix
  ];
}
