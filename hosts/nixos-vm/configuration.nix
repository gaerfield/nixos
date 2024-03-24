# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).

{ config, pkgs, ... }:

{

  imports = [
    ../../modules/system.nix
    ../../modules/gnome-wayland.nix
    
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];

# Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.gaerfield = {
    isNormalUser = true;
    description = "gaerfield";
    extraGroups = ["networkmanager" "wheel"];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDiDO/rEP3n57KmIM56Z8WHMq+gLa0eiKFD1YMBi+CTU0wGdFO0QZcwrZpCsf2Mkn7xa5PaRpF5xnqjgHVUt0CNKIWX531fwDdp9iWCGs69sMoM0blw1SRPOewvBKnFJWzOEarn3ZALnllQizSIKJsm1imWeYe4kw3GbVmSPVF+cOTlcBVjM+vS3ARe482ERGmfNFUpw5i3MtnqOEx5AGbgdJYSxWXH8/DCbFm0/ghOoWH1vGvnPREppQd7ND1otpBB/fiK0PRblzEtvtpGsP2IbzVlN8tmq9c4XGQns5dPQ5jdPlJQmDGp7eE3v2oD1BraPA5rjQuvRBeaDOMfkdNkquGfIq6l46XFDKyT7HAdmIKnBwVxZWszgZVO6TWvwtQuxrO8oVmQhxXfbI/bndgPj5M/43BUvrTPfMvSDjsg2iU+mK9yWzUvQqtUF1TxXbDBkpO73E6ImR9vKzo4EKRXXSZNaMix1bFhlx/hdnaGamDvtGBdRXRYKwAJA4ZzQG/jKpHnZaKSZBS+kZrNkQ4ZQlvGEt80jIm6W8lGDzE8a8FuegDJT5cfk/wcoaCOS3dyaCnFpC+ZZw4EqNj/tIxrSdXA4YbHrAvkOdjCZrepvKF6u2OTXlkfBBm9jznvp70nBw2BtrNp/emM7fW2wo3+bM//CIaBIbc+BvGqx5I2Lw=="
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB/IYHcIdtyzsEVdfIkaG6FbRQVXBmFNQaMOkvp1sCNb gaerfield@posteo.net"
    ];
  };

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Enable networking
  networking.networkmanager.enable = true;

  # Configure keymap in X11
  services.xserver = {
    layout = "de";
    xkbVariant = "nodeadkeys";
  };

  # Configure console keymap
  console.keyMap = "de-latin1-nodeadkeys";

  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  programs = {
    chromium.enable = true;
    fish.enable = true;
  };

  ### automatic login ###
  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "gaerfield";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;


  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # qemu guest extensions
  # Had it enabled for sharing a local folder, but it's pretty useless 
  # (meaning slow). 'sshfs' works better
  #services.qemuGuest.enable = true;
  #services.spice-vdagentd.enable = true;
  #services.spice-webdavd.enable = true;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?

}
