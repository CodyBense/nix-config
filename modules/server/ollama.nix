{
  config,
  lib,
  pkgs,
  ...
}:

{
  services.ollama = {
    enable = true;
    package = pkgs.ollama-cuda;
    loadModels = [
      "llama3.2:3B"
      "deepseek-r1:1.5b"
    ];
  };
}
