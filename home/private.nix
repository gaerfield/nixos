{ config, pkgs, ... }:

{
  imports = [
     ./base.nix
  ];

  home = {
    username = "gaerfield";
    homeDirectory = "/home/gaerfield";
    stateVersion = "23.11";
  };
}
