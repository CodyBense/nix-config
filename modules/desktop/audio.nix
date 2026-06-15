{
  config,
  lib,
  pkgs,
  ...
}:

{
  # hardware.enableRedistributableFirmware = true;
  # hardware.firmware = with pkgs; [
  #   sof-firmware
  #   linux-firmware
  # ];

  security.rtkit.enable = true;
  services.pulseaudio.enable = false;

  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # jack.enable = true;
    # wireplumber.enable = true;
    # wireplumber.extraConfig = {
    #   "monitor.alas" = {
    #     "monitor.alsa.rules" = [
    #       {
    #         matches = [ { "node.name" = "~alsa_output.*"; } ];
    #         actions."update-props" = {
    #           "audio.format" = "S32LE";
    #           "audio.rate" = 48000;
    #           "api.alsa.period-size" = 256;
    #         };
    #       }
    #     ];
    #   };
    # };
  };

  environment.systemPackages = with pkgs; [
    pavucontrol
    # playerctl
    # wireplumber
    # alsa-utils
    # sof-firmware
  ];
}
