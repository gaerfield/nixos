{ config, pkgs, ... }:

{
  imports = [
     ./../../home
     ./../../home/teams-for-linux.nix
     ./../../home/virtualization.nix
  ];

  home = {
    username = "blaschke";
    homeDirectory = "/home/blaschke";
    stateVersion = "23.11";
  };
}
