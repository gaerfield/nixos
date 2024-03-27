{ pkgs, ... }: {
  # zlib is somehow required by java
  home.packages = [ pkgs.temurin-bin ];
}
