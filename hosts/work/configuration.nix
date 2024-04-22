# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).
{
  imports =
    [
      ./../../modules/nixos
      ./../../pkg-configs/nixos/system.nix
      ./../../pkg-configs/nixos/bluetooth.nix
      ./../../pkg-configs/nixos/gnome-wayland.nix
      ./../../pkg-configs/nixos/virtualization.nix
      ./../../pkg-configs/nixos/podman.nix
      ./../../pkg-configs/nixos/nix-ld.nix
      ./../../pkg-configs/nixos/appimage.nix
      ./hardware-configuration.nix
    ];
  
  config = {
    system.username = "blaschke";
    system.autologin = true;

    # Use the systemd-boot EFI boot loader.
    boot.loader.systemd-boot.enable = true;
    boot.loader.efi.canTouchEfiVariables = true;
    # depending on how you configured your disk mounts, change this to /boot or /boot/efi.
    boot.loader.efi.efiSysMountPoint = "/boot";

    networking.hostName = "bms-cs21337";
    # Pick only one of the below networking options.
    # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networking.networkmanager.enable = true;

    # Configure keymap in X11
    services.xserver.xkb = {
      layout = "de";
      variant = "nodeadkeys";
    };

    # Configure console keymap
    console.keyMap = "de-latin1-nodeadkeys";

    programs = {
      chromium.enable = true;
      fish.enable = true;
    };
    
    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    system.stateVersion = "23.11"; # Did you read the comment?
  };
}
