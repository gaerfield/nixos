{
  programs.fish = {
    shellAbbrs.bft-gui = {
      expansion = "xdg-open http://localhost:5200/iot-debug-tool/ && ssh -NT -L 5200:localhost:5200 -L 5100:localhost:5100 bft-%";
      setCursor = true;
    };
    shellAbbrs.bft-display = {
      expansion = "xdg-open http://localhost:5200/checkout-display/ && ssh -NT -L 8080:localhost:8080 -L 80:localhost:80 bft-%";
      setCursor = true;
    };
  };
}