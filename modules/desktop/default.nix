{ config, pkgs, ... }:

{
  imports = [
    ./audio.nix
    ./bluetooth.nix
    ./browsers.nix
    ./email.nix
    ./fonts.nix
    ./gaming.nix
    # ./gnome.nix
    ./hibernation.nix
    ./hyprland.nix
    ./kanata.nix
    ./networking.nix
    # ./niri.nix
    ./storage.nix
    ./virtualisation.nix
  ];
}
