{
  programs.fish = {
    shellAbbrs.bft-gui = {
      expansion = "xdg-open http://localhost:5200/iot-debug-tool/ && ssh -NT -L 5200:localhost:5200 -L 5100:localhost:5100 bft-%";
      setCursor = true;
    };
    shellAbbrs.bft-display = {
      expansion = "xdg-open http://localhost/checkout-display/ && ssh -NT -L 8080:localhost:8080 -L 80:localhost:80 bft-%";
      setCursor = true;
    };
    shellAbbrs.shopware-forward = {
      expansion = "gcloud compute ssh shopware-% -- -NL 80:localhost:80 ";
      setCursor = true;
    };
    functions.mount-bft = {
      # alias declared as function (because shellAliases always blindly appends $argv)
      # https://www.sean.sh/log/when-an-alias-should-actually-be-an-abbr/
      wraps = "sshfs bft-\\$1; ~/mount/bfts/bft-\\$1";
      description = "mount remote bfts home dir";
      body = "sshfs bft-$argv[1]: ~/mounts/bfts/bft-$argv[1]";
    };
    shellAbbrs.umount-bft = {
      expansion = "umount ~/mounts/bfts/bft-%";
      setCursor = true;
    };
    functions.mount-bs = {
      # alias declared as function (because shellAliases always blindly appends $argv)
      # https://www.sean.sh/log/when-an-alias-should-actually-be-an-abbr/
      wraps = "sshfs bs-\\$1; ~/mount/bfts/bs-\\$1";
      description = "mount remote bs home dir";
      body = "sshfs bs-$argv[1]: ~/mounts/bfts/bs-$argv[1]";
    };
    shellAbbrs.umount-bs = {
      expansion = "umount ~/mounts/bfts/bs-%";
      setCursor = true;
    };
  };
}