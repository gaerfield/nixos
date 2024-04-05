# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, modulesPath, ... }:

{
  imports =
    [(modulesPath + "/installer/scan/not-detected.nix")
    ];

  # boot.kernelPackages = pkgs.linuxPackages_latest;
  # boot.kernelPackages = pkgs.linuxPackages_xanmod_latest;
  
  boot.initrd.availableKernelModules = [ "xhci_pci" "thunderbolt" "ahci" "nvme" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.initrd.kernelModules = [ ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModprobeConfig = "options kvm_intel nested=1"; # for intel cpu
  boot.extraModulePackages = [ ];
  # clear /tmp on boot to get a stateless /tmp directory.
  # boot.tmp.cleanOnBoot = true;
  
  # supported file systems, so we can mount any removable disks with these filesystems
  boot.supportedFilesystems = [
    "ext4"
    "btrfs"
    "xfs"
    "ntfs"
    "fat"
    "vfat"
    "cifs" # mount windows share
  ];

  boot.initrd = {
    # unlocked luks devices via a keyfile or prompt a passphrase.
    luks.devices."crypted-nixos" = {
      device = "/dev/disk/by-uuid/0217c461-9527-4d45-adf2-307cf10ea8eb";
      # the keyfile(or device partition) that should be used as the decryption key for the encrypted device.
      # if not specified, you will be prompted for a passphrase instead.
      # keyFile = "/root-part.key";

      # whether to allow TRIM requests to the underlying device.
      # it's less secure, but faster.
      allowDiscards = true;
      
      # Whether to bypass dm-crypt’s internal read and write workqueues.
      # Enabling this should improve performance on SSDs;
      # https://wiki.archlinux.org/index.php/Dm-crypt/Specialties#Disable_workqueue_for_increased_solid_state_drive_(SSD)_performance
      bypassWorkqueues = true;
    };
  };
  
  fileSystems."/" =
    { device = "/dev/disk/by-uuid/185c165e-7124-47f1-9c75-c5674ef01818";
      fsType = "btrfs";
      options = [ "subvol=@root" ];
    };
  
  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/185c165e-7124-47f1-9c75-c5674ef01818";
      fsType = "btrfs";
      options = [ "subvol=@nix" "noatime" "compress-force=zstd:1"];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/185c165e-7124-47f1-9c75-c5674ef01818";
      fsType = "btrfs";
      options = [ "subvol=@home" "noatime" "compress-force=zstd:1"];
    };

  fileSystems."/tmp" =
    { device = "/dev/disk/by-uuid/185c165e-7124-47f1-9c75-c5674ef01818";
      fsType = "btrfs";
      options = [ "subvol=@tmp" "compress-force=zstd:1"];
    };

  fileSystems."/persistent" =
    { device = "/dev/disk/by-uuid/185c165e-7124-47f1-9c75-c5674ef01818";
      fsType = "btrfs";
      options = [ "subvol=@persistent" "noatime" "compress-force=zstd:1"];
    };

  fileSystems."/swap" =
    { device = "/dev/disk/by-uuid/185c165e-7124-47f1-9c75-c5674ef01818";
      fsType = "btrfs";
      options = [ "subvol=@swap" "ro" ];
    };
  
  # remount swapfile in read-write mode
  fileSystems."/swap/swapfile" = {
    # the swapfile is located in /swap subvolume, so we need to mount /swap first.
    depends = ["/swap"];

    device = "/swap/swapfile";
    fsType = "none";
    options = ["bind" "rw"];
  };
  
  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/22EC-2E08";
      fsType = "vfat";
    };

  swapDevices = [
    {device = "/swap/swapfile";}
  ];

  # Enables DHCP on each ethernet and wireless interface. In case of scripted networking
  # (the default) this is the recommended approach. When using systemd-networkd it's
  # still possible to use this option, but it's recommended to use it in conjunction
  # with explicit per-interface declarations with `networking.interfaces.<interface>.useDHCP`.
  networking.useDHCP = lib.mkDefault true;
  # networking.interfaces.enp0s31f6.useDHCP = lib.mkDefault true;
  # networking.interfaces.wlp0s20f3.useDHCP = lib.mkDefault true;

  nixpkgs.hostPlatform = lib.mkDefault "x86_64-linux";
  powerManagement.cpuFreqGovernor = lib.mkDefault "powersave";
  hardware.cpu.intel.updateMicrocode = lib.mkDefault config.hardware.enableRedistributableFirmware;
}
