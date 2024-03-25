{ config, pkgs, ... }:

{
  imports = [
     ./../../home
  ];

  home = {
    username = "blaschke";
    homeDirectory = "/home/blaschke";
    stateVersion = "23.11";
  };
}
