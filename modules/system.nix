{ pkgs, lib, ... }:

{
  # ============================= User related =============================

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.gaerfield = {
    isNormalUser = true;
    description = "gaerfield";
    extraGroups = ["networkmanager" "wheel"];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDiDO/rEP3n57KmIM56Z8WHMq+gLa0eiKFD1YMBi+CTU0wGdFO0QZcwrZpCsf2Mkn7xa5PaRpF5xnqjgHVUt0CNKIWX531fwDdp9iWCGs69sMoM0blw1SRPOewvBKnFJWzOEarn3ZALnllQizSIKJsm1imWeYe4kw3GbVmSPVF+cOTlcBVjM+vS3ARe482ERGmfNFUpw5i3MtnqOEx5AGbgdJYSxWXH8/DCbFm0/ghOoWH1vGvnPREppQd7ND1otpBB/fiK0PRblzEtvtpGsP2IbzVlN8tmq9c4XGQns5dPQ5jdPlJQmDGp7eE3v2oD1BraPA5rjQuvRBeaDOMfkdNkquGfIq6l46XFDKyT7HAdmIKnBwVxZWszgZVO6TWvwtQuxrO8oVmQhxXfbI/bndgPj5M/43BUvrTPfMvSDjsg2iU+mK9yWzUvQqtUF1TxXbDBkpO73E6ImR9vKzo4EKRXXSZNaMix1bFhlx/hdnaGamDvtGBdRXRYKwAJA4ZzQG/jKpHnZaKSZBS+kZrNkQ4ZQlvGEt80jIm6W8lGDzE8a8FuegDJT5cfk/wcoaCOS3dyaCnFpC+ZZw4EqNj/tIxrSdXA4YbHrAvkOdjCZrepvKF6u2OTXlkfBBm9jznvp70nBw2BtrNp/emM7fW2wo3+bM//CIaBIbc+BvGqx5I2Lw=="
    ];
  };

  # do garbage collection weekly to keep disk usage low
  nix.gc = {
    automatic = lib.mkDefault true;
    dates = lib.mkDefault "weekly";
    options = lib.mkDefault "--delete-older-than 7d";
  };

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Set your time zone.
  time.timeZone = "Europe/Berlin";

  # Select internationalisation properties.
  i18n.defaultLocale = "de_DE.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "de_DE.UTF-8";
    LC_IDENTIFICATION = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
    LC_MONETARY = "de_DE.UTF-8";
    LC_NAME = "de_DE.UTF-8";
    LC_NUMERIC = "de_DE.UTF-8";
    LC_PAPER = "de_DE.UTF-8";
    LC_TELEPHONE = "de_DE.UTF-8";
    LC_TIME = "de_DE.UTF-8";
  };

  # Enable CUPS to print documents.
  services.printing.enable = true;

  fonts = {
    packages = with pkgs; [
      # icon fonts
      material-design-icons

      # normal fonts
      noto-fonts
      noto-fonts-color-emoji

      # nerdfonts
      (nerdfonts.override {fonts = ["FiraCode" "JetBrainsMono"];})
    ];

    # use fonts specified by user rather than default ones
    enableDefaultPackages = false;

    # user defined fonts
    # the reason there's Noto Color Emoji everywhere is to override DejaVu's
    # B&W emojis that would sometimes show instead of some Color emojis
    fontconfig.defaultFonts = {
      serif = ["Noto Serif" "Noto Color Emoji"];
      sansSerif = ["Noto Sans" "Noto Color Emoji"];
      monospace = ["JetBrainsMono Nerd Font" "Noto Color Emoji"];
      emoji = ["Noto Color Emoji"];
    };
  };

  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  networking.firewall.enable = false;

  # Enable the OpenSSH daemon.
  services.openssh = {
    enable = true;
    settings = {
      X11Forwarding = true;
      PermitRootLogin = "no"; # disable root login
      PasswordAuthentication = false; # disable password login
    };
    openFirewall = true;
  };


  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    neovim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
    wget
    curl
    git
    sysstat
    lm_sensors
  ];

  # Enable sound with pipewire.
  sound.enable = true;
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };

}
