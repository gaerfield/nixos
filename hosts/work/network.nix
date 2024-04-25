{ pkgs, ... }: {
  environment.etc."systemd/resolved.conf.d/esag-md.conf".source = (pkgs.formats.toml { }).generate "something" {
    Match.Name = "eno1";
    Network = {
      DNSSECNegativeTrustAnchors="lan";
      DHCP="yes";
    };
    DHCP.UseDomains=true;
  };
}
