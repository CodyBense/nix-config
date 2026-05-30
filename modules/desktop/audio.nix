{
  config,
  lib,
  pkgs,
  ...
}:

{
  hardware.enableRedistributableFirmware = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    wireplumber.enable = true;
    jack.enable = true;
  };

  environment.systemPackages = with pkgs; [
    pavucontrol
    playerctl
    wireplumber
    alsa-utils
    sof-firmware
  ];
}
