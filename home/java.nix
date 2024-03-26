{ pkgs, ... }: {
  home.packages = [ pkgs.temurin-bin pkgs.zlib ];
  home.sessionVariables = {
    _JAVA_OPTIONS="-Dawt.useSystemAAFontSettings=lcd";
    LD_LIBRARY_PATH="${pkgs.lib.makeLibraryPath [ pkgs.zlib ]}:$LD_LIBRARY_PATH";
  };
}