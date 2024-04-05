{
  # https://nixos.wiki/wiki/Virt-manager
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  users.users.blaschke.extraGroups = [ "libvirtd" ];

  # allow nested virtualization (https://nixos.wiki/wiki/Libvirt)
  boot.extraModprobeConfig = "options kvm_intel nested=1";
}