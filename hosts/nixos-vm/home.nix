{ config, pkgs, ... }:

{
  imports = [
     ./../../home
  ];

  home = {
    username = "gaerfield";
    homeDirectory = "/home/gaerfield";
    stateVersion = "23.11";
  };
}
