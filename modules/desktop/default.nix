{ config, pkgs, ... }:

{
  imports = [
    ./audio.nix
    ./bluetooth.nix
    ./browsers.nix
    ./fonts.nix
    ./gnome.nix
    ./hibernation.nix
    ./kanata.nix
    ./networking.nix
    ./niri.nix
    ./storage.nix
    ./virtualisation.nix
  ];
}
