{
  # https://nixos.wiki/wiki/Flatpak
  # https://flatpak.org/setup/NixOS
  # flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo  
  services.flatpak.enable = true;

  # https://itsfoss.com/downgrade-flatpak-packages/
  # flatpak search postman
  # https://github.com/flathub/com.getpostman.Postman
  # flatpak remote-info --log flathub com.getpostman.Postman
  # sudo flatpak update --commit=9ca85f13b296a3b221f7d9d0262afd860b670a89 com.getpostman.Postman
}