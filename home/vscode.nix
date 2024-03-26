{ config, pkgs, lib, ... }: {
  fonts.fontconfig.enable = true;
  home.packages = [ (pkgs.nerdfonts.override { fonts = [ "JetBrainsMono" ]; }) ];

  programs.fish.shellAbbrs.code = "codium";

  programs.vscode = {
    enable = true;
    package = pkgs.vscodium;

    enableUpdateCheck = false;
    enableExtensionUpdateCheck = false;

    mutableExtensionsDir = false;

    extensions = with pkgs.vscode-extensions; [
      redhat.vscode-yaml
    ];

    userSettings = {
      "editor.fontFamily" = "JetBrainsMono Nerd Font";
      "terminal.external.linuxExec" = "${pkgs.alacritty}/bin/alacritty";
      "terminal.integrated.defaultProfile.linux" = "fish";
      "terminal.integrated.profiles.linux" = {
        bash.path = "${pkgs.bash}/bin/bash";
        fish.path = "${pkgs.fish}/bin/fish";
        sh.path = "${pkgs.bashInteractive}/bin/sh";
        zsh.path = "${pkgs.zsh}/bin/zsh";
      };
      "terminal.integrated.smoothScrolling" = true;
      "window.autoDetectColorScheme" = true;
      "workbench.colorTheme" = "Solarized Light";
      "workbench.preferredDarkColorTheme" = "Solarized Dark";
      "workbench.preferredLightColorTheme" = "Solarized Light";
    };
  };
}
