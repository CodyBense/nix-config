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
    acceleration = "cuda";
    loadModels = [
      "llama3.2:3B"
      "deepseek-r1:1.5b"
    ];
  };

  services.open-webui.enable = true;
  # default port 8080
}
