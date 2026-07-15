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
      "deepseek-r1:7b"
      "qwen3.5:9b"
      "gemma4:12b"
    ];
    host = "0.0.0.0";
    port = 11434;
  };

  services.open-webui = {
    enable = true;
    port = 8080;
    host = "0.0.0.0";
    environment = {
      OLLAMA_BASE_URL = "http://127.0.0.1:11434";
};
    openFirewall = true;
  };

  networking.firewall.allowedTCPPorts = [ 8080 ];
}
