{ pkgs, config, system, ... }: {

  home.file.".local/bin/track-working-day" = {
    source = ./track-working-day;
    executable = true;
  };

 systemd.user.services.track-working-day = {
    Unit = {
      Description = "tracks my working day by logging logins, logouts, bootups and shutdowns";
    };
    Install = {
      WantedBy = [ "default.target" ];
    };
    Service = {
      ExecStart = "%h/.local/bin/track-working-day start";
    };
  };
}