{ pkgs, lib, colors, ... }:
let
  extensions = [
    pkgs.gnomeExtensions.dash-to-dock
  ];
in {
  imports = [
    ./theme.nix
    ./autostart.nix
    ./flameshot.nix
    ./alacritty.nix
  ];

  fonts.fontconfig.enable = true;
  
  # TODO remove when `pkgs.cantarell-fonts` is no more broken on darwin
  #home.packages = lib.optionals pkgs.stdenv.isLinux ([
  #  pkgs.cantarell-fonts
  #  (pkgs.nerdfonts.override { fonts = [ "RobotoMono" ]; })
  #
  #  pkgs.papirus-icon-theme
  #  pkgs.yaru-theme
  #] ++ extensions);

  dconf = {
    enable = true;

    settings = {
      "org/gnome/desktop/interface".enable-hot-corners = false;
      "org/gnome/shell/app-switcher".current-workspace-only = true;
      "org/gnome/mutter" = {
        dynamic-workspaces = true;
        workspaces-only-on-primary = true;
      };
      
      "ca/desrt/dconf-editor/Settings".show-warning = false;
      "org/gnome/desktop/privacy" = {
        old-files-age = 30;
        remove-old-temp-files = true;
        remove-old-trash-files = true;
        report-technical-problems = false;
        send-software-usage-stats = false;
      };
      "org/gnome/desktop/search-providers" = {
        disabled = [ "org.gnome.Contacts.desktop" ];
        sort-order = [ "org.gnome.Documents.desktop" "org.gnome.Nautilus.desktop" ];
      };
      "org/gnome/desktop/wm/keybindings" = {
        close=["<Super>q"];
        cycle-group=["<Super>Tab"];
        cycle-group-backward=["<Shift><Super>Tab"];
        minimize=["<Super>w"];
        move-to-monitor-left=["<Shift><Super>Left"];
        move-to-monitor-right=["<Shift><Super>Right"];
        move-to-workspace-left=["<Control><Super>Left"];
        move-to-workspace-right=["<Control><Super>Right"];
        switch-applications=["<Alt>Tab"];
        switch-applications-backward=["<Shift><Alt>Tab"];
        switch-to-workspace-left=["<Super>Left"];
        switch-to-workspace-right=["<Super>Right"];
        toggle-maximized=["<Super>m"];
        toggle-message-tray=[];
      };
      "org/gnome/mutter/keybindings" = {
        toggle-tiled-left=["<Alt><Super>Left"];
        toggle-tiled-right=["<Alt><Super>Right"];
      };
      "org/gnome/settings-daemon/plugins/media-keys" = {
        custom-keybindings=[
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/"
          "/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/"
        ];
        home=["<Super>e"];
        www=["<Super>b"];
      };

      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0" = {
        name = "terminal";
        command = "alacritty -e byobu";
        binding = "<Super>x";
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1" = {
        name = "gnome-system-monitor";
        command = "gnome-system-monitor";
        binding = "<Shift><Control>Escape";
      };
      "org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2" = {
        name = "restart gnome";
        command = "killall -3 gnome-shell";
        binding = "<Ctrl><Alt>BackSpace";
      };
    };
  };
}
