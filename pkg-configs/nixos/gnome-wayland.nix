{ pkgs, lib, ... }:

{
  # https://nixos.wiki/wiki/GNOME
  
  # Enable the GNOME Desktop Environment.
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  
  environment = {
    systemPackages = with pkgs; [ 
      gnome.dconf-editor
      gnome.adwaita-icon-theme
      gnomeExtensions.appindicator
      firefox
      chromium
      alacritty
      noto-fonts-color-emoji
      wl-clipboard
      libsecret
    ];

    # enable wayland support for all chromium and most electron apps
    sessionVariables.NIXOS_OZONE_WL = "1";

    gnome.excludePackages = (with pkgs; [
      # gnome-photos
      gnome-tour
    ]) ++ (with pkgs.gnome; [
      cheese # webcam tool
      gnome-contacts
      gnome-music
      # gnome-terminal
      # gedit # text editor
      epiphany # web browser
      geary # email reader
      # evince # document viewer
      # gnome-characters
      totem # video player
      tali # poker game
      iagno # go game
      hitori # sudoku game
      atomix # puzzle game
    ]);
  };

  programs.dconf.enable = true;
  services.udev.packages = with pkgs; [ gnome.gnome-settings-daemon ];

  # enable tripple buffering - probably to be removed on next stable
  nixpkgs.overlays = [
    (final: prev: {
      gnome = prev.gnome.overrideScope' (gnomeFinal: gnomePrev: {
        mutter = gnomePrev.mutter.overrideAttrs ( old: {
          src = pkgs.fetchgit {
            url = "https://gitlab.gnome.org/vanvugt/mutter.git";
            # GNOME 45: triple-buffering-v4-45
            rev = "0b896518b2028d9c4d6ea44806d093fd33793689";
            sha256 = "sha256-mzNy5GPlB2qkI2KEAErJQzO//uo8yO0kPQUwvGDwR4w=";
          };
        } );
      });
    })
  ];

  nixpkgs.config.allowAliases = false;

}
