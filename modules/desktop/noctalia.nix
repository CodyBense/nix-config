{ pkgs, inputs, ... }:
{
  environment.systemPackages = with pkgs; [
    inputs.noctalia.packages.${pkgs.stdenv.hostPlatform.system}.default
    brightnessctl
    ddcutil
    gpu-screen-recorder
    matugen
    wlsunset
    nwg-look
    adw-gtk3
    kdePackages.qt6ct
  ];

  # networkmanager and bluetooth enables in their owm modules
  services.power-profiles-daemon.enable = true;
  services.upower.enable = true;
}
