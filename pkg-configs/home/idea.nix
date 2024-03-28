{ pkgs, ... }: {
  home.packages = with pkgs.jetbrains; [ 
    pkgs.jetbrains-toolbox
    idea-ultimate
    webstorm
    datagrip
  ];
}