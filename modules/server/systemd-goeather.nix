{
  config,
  lib,
  pkgs,
  ...
}:
{
  systemd.timers."goeather" = {
    wantedBy = [ "goeather.target" ];
    timerConfig = {
      OnCalendar = "Sun 14:00:00";
      Unit = "goeather.service";
    };
  };

  systemd.services."goeather" = {
    script = ''
      set -eu
      ~/workspaces/github/CodyBense/goeather/main.go
    '';
  };
}
