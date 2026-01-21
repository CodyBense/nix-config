{ config, lib, pkgs, ... }:

{
  services.minecraft = {
    enable = true;
    eula = true;
    declarative = true;

    dataDir = "~/minecraft-server/vanilla";

    serverProperties = {
      gamemode = "survival";
      difficulty = "hard";
      simulation-distance = 10;
      level-name = "vanilla";
    };
  };
}
