{
  programs.fish = {
    shellAbbrs.bft-gui = {
      expansion = "xdg-open http://localhost:5200/iot-debug-tool/ && ssh -NT -L 5200:localhost:5200 -L 5100:localhost:5100 -L 42069:localhost:42069 bft-%";
      setCursor = true;
    };
  };
}