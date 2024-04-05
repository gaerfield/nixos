{ config, ... }: {
  home.sessionVariables.BROWSER = "${config.programs.firefox.package}/bin/firefox";

  programs.firefox = {
    enable = true;
  };
  
  home.sessionVariables = {
    "MOZ_ENABLE_WAYLAND" = 1;
  };
  
}

