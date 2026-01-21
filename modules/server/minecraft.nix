{ config, lib, pkgs, username, ... }:

{
  services.minecraft-server = {
    enable = true;
    eula = true;
    declarative = true;

    dataDir = "/home/${username}/minecraft-server/vanilla";

    serverProperties = {
      # default port 25565
      gamemode = "survival";
      difficulty = "hard";
      simulation-distance = 10;
      level-name = "vanilla";
    };
  };
}
