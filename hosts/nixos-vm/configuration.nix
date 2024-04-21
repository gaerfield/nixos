# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
{
  imports = [
    ./../../modules/nixos
    ./../../pkg-configs/nixos/system.nix
    ./../../pkg-configs/nixos/gnome-wayland.nix
    
    # Include the results of the hardware scan.
    ./hardware-configuration.nix
  ];
  config = {
    system.autologin = true;

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

    # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
    system.stateVersion = "23.11"; # Did you read the comment?
  };
}
