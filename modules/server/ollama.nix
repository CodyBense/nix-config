{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.ollama = {
    enable = true;
    loadModels = [ "llama3.2:3B" ];
  };
}
