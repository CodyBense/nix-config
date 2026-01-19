{ config, ... }:

let
  mkOutOfStoreSymlink = path: config.lib.file.mkOutOfStoreSymlink path;
  configDir = "${config.home.homeDirectory}/nix-config/dotfiles";
in
  {
    home.file = {
      ".config/niri".source = mkOutOfStoreSymlink "${configDir}/niri";
      ".config/noctalia".source = mkOutOfStoreSymlink "${configDir}/noctalia";
      ".config/kitty".source = mkOutOfStoreSymlink "${configDir}/kitty";
      ".config/doom".source = mkOutOfStoreSymlink "${configDir}/doom";
      ".bashrc".source = mkOutOfStoreSymlink "${configDir}/bash/.bashrc";
      ".bash_profile".source = mkOutOfStoreSymlink "${configDir}/bash/.bash_profile";
      ".config/starship".source = mkOutOfStoreSymlink "${configDir}/startship.toml";
      ".config/rofi".source = mkOutOfStoreSymlink "${configDir}/rofi";
      ".config/zellij".source = mkOutOfStoreSymlink "${configDir}/zellij";
    };
  }
