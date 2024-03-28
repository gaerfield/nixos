# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [
      ./../../pkg-configs/nixos/system.nix
      ./../../pkg-configs/nixos/gnome-wayland.nix
      ./../../pkg-configs/nixos/virtualization.nix
      ./../../pkg-configs/nixos/podman.nix
      ./../../pkg-configs/nixos/nix-ld.nix
      ./../../pkg-configs/nixos/appimage.nix
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  # depending on how you configured your disk mounts, change this to /boot or /boot/efi.
  boot.loader.efi.efiSysMountPoint = "/boot";

  networking.hostName = "bms-cs21337";
  # Pick only one of the below networking options.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
  networking.networkmanager.enable = true;

  users.users.blaschke = {
    isNormalUser = true;
    description = "blaschke";
    extraGroups = ["networkmanager" "wheel"];
    openssh.authorizedKeys.keys = [
      "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDiDO/rEP3n57KmIM56Z8WHMq+gLa0eiKFD1YMBi+CTU0wGdFO0QZcwrZpCsf2Mkn7xa5PaRpF5xnqjgHVUt0CNKIWX531fwDdp9iWCGs69sMoM0blw1SRPOewvBKnFJWzOEarn3ZALnllQizSIKJsm1imWeYe4kw3GbVmSPVF+cOTlcBVjM+vS3ARe482ERGmfNFUpw5i3MtnqOEx5AGbgdJYSxWXH8/DCbFm0/ghOoWH1vGvnPREppQd7ND1otpBB/fiK0PRblzEtvtpGsP2IbzVlN8tmq9c4XGQns5dPQ5jdPlJQmDGp7eE3v2oD1BraPA5rjQuvRBeaDOMfkdNkquGfIq6l46XFDKyT7HAdmIKnBwVxZWszgZVO6TWvwtQuxrO8oVmQhxXfbI/bndgPj5M/43BUvrTPfMvSDjsg2iU+mK9yWzUvQqtUF1TxXbDBkpO73E6ImR9vKzo4EKRXXSZNaMix1bFhlx/hdnaGamDvtGBdRXRYKwAJA4ZzQG/jKpHnZaKSZBS+kZrNkQ4ZQlvGEt80jIm6W8lGDzE8a8FuegDJT5cfk/wcoaCOS3dyaCnFpC+ZZw4EqNj/tIxrSdXA4YbHrAvkOdjCZrepvKF6u2OTXlkfBBm9jznvp70nBw2BtrNp/emM7fW2wo3+bM//CIaBIbc+BvGqx5I2Lw=="
      "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIB/IYHcIdtyzsEVdfIkaG6FbRQVXBmFNQaMOkvp1sCNb gaerfield@posteo.net"
    ];
  };

  # Configure keymap in X11
  services.xserver = {
    layout = "de";
    xkbVariant = "nodeadkeys";
  };

  # Configure console keymap
  console.keyMap = "de-latin1-nodeadkeys";

  programs = {
    chromium.enable = true;
    fish.enable = true;
  };

  ### automatic login ###
  # Enable automatic login for the user.
  services.xserver.displayManager.autoLogin.enable = true;
  services.xserver.displayManager.autoLogin.user = "blaschke";

  # Workaround for GNOME autologin: https://github.com/NixOS/nixpkgs/issues/103746#issuecomment-945091229
  systemd.services."getty@tty1".enable = false;
  systemd.services."autovt@tty1".enable = false;
  
  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  system.stateVersion = "23.11"; # Did you read the comment?

}
