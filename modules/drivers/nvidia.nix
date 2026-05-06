{
  config,
  lib,
  pkgs,
  ...
}:

{
  # nvidia driver settings
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  hardware.nvidia.open = false;

  #Multi-Process Service
  systemd.services.nvidia-mps = {
    description = "NVIDIA CUDA Multi-Process Service";
    after = [ "nvidia-persistenced.service" ];
    requires = [ "nvidia-persistenced.service" ];
    wantedBy = [ "multi-user.target" ];
    path = [ config.hardware.nvidia.package.bin ];
    serviceConfig = {
      Type = "forking";
      ExecStart = "${config.hardware.nvidia.package.bin}/bin/nvidia-cuda-mps-control -d";
      ExecStop = "${pkgs.writeShellScript "nvidia-mps-stop" ''
        echo quit | ${config.hardware.nvidia.package.bin}/bin/nvidia-cuda-mps-control
      ''}";
      Restart = "on-failure";
      RestartSec = 5;
    };
  };
}
