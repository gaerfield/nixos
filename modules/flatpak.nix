{
  # https://nixos.wiki/wiki/Flatpak
  # https://flatpak.org/setup/NixOS
  # flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo  
  services.flatpak.enable = true;

  # flatpak remote-info --log flathub com.getpostman.Postman
}