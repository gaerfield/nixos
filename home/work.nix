{ config, pkgs, ... }:

{
  imports = [
     ./base.nix
  ];

  home = {
    username = "blaschke";
    homeDirectory = "/home/blaschke";
    stateVersion = "23.11";
  };
}
