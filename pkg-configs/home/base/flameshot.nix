{ pkgs, config, lib, ... }: {
  home.packages = [ pkgs.flameshot ];

  xdg.configFile."flameshot/flameshot.ini".source = (pkgs.formats.ini { }).generate "flameshot.ini" {
    General = {
      disabledTrayIcon = false;
      drawColor = "#ff0000";
      drawFontSize=32;
      drawThickness=4;
      filenamePattern = "%Y%m%d_%H%M%S";
      savePath = "${config.home.homeDirectory}/Bilder";
      showHelp = false;
      showStartupLaunchMessage = false;
    };
  };
}