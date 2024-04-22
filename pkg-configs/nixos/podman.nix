{ config, pkgs, ... }: 
let 
  mainuser = config.system.username;
in {
  virtualisation = {
    containers.registries.search = [ "docker.io" ];

    podman = {
      enable = true;

      # Create a `docker` alias for podman, to use it as a drop-in replacement
      dockerCompat = true;
      dockerSocket.enable = true;
      # Required for containers under podman-compose to be able to talk to each other.
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  environment = {
    systemPackages = [ pkgs.podman-compose ];
    shellAliases.docker-compose = "${config.virtualisation.podman.package}/bin/podman-compose";
  };

  users.users."${mainuser}".extraGroups = [ "docker" ];

  programs.fish = {
    shellAbbrs.dco = "docker compose";
  };
}