{ config, pkgs, ... }:

{
  imports = [
    ./base.nix
    ./doom.nix
    ./tmux.nix
    ./web.nix
  ];
}
