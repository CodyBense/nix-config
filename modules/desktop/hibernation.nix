{
  config,
  lib,
  pkgs,
  ...
}:

{
  boot.kernelParams = [ "resume_offset=47802368" ];
  boot.resumeDevice = "/dev/disk/by-uuid/221444e9-468e-4de0-9bbe-9d19e75ed0e4";
  powerManagement.enable = true;
  swapDevices = [
    {
      device = "/var/lib/swapfile";
      size = 32 * 1024;
    }
  ];
}
