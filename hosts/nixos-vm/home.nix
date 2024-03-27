{
  inputs,
  outputs,
  lib,
  config,
  pkgs,
  ...
}: {
  
  imports = [
    ./../../home
  ];

  # https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "23.11";

  home = {
    username = "gaerfield";
    homeDirectory = "/home/gaerfield";
  };
}