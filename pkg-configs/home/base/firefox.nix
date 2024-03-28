{ pkgs, lib, config, ... }: {
  home.sessionVariables.BROWSER = "${config.programs.firefox.package}/bin/firefox";

  programs.firefox = {
    enable = true;
  };
}

