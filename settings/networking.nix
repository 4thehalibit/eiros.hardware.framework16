{ pkgs, ... }:
{
  # Many local/corporate resolvers (e.g. the LSE office gateway 192.168.4.1) return
  # unsigned answers, which systemd-resolved rejects as "DNSSEC validation failed:
  # no-signature" even under allow-downgrade — breaking resolution on those networks.
  # Disable DNSSEC enforcement so the network-provided resolver is trusted as-is;
  # this keeps internal hostnames resolvable while fixing public lookups.
  services.resolved.dnssec = "false";

  # Prefer ethernet over wifi when both are connected. Force Cloudflare/Google DNS
  # on every connection so DNSSEC and resolution behave the same across networks
  # (home, hotspot, hotel, office) — many local resolvers mishandle DNSSEC.
  environment.etc."NetworkManager/conf.d/10-route-priority.conf".text = ''
    [connection]
    ipv4.dns=1.1.1.1,1.0.0.1,8.8.8.8,8.8.4.4
    ipv4.ignore-auto-dns=true
    ipv6.dns=2606:4700:4700::1111,2606:4700:4700::1001,2001:4860:4860::8888
    ipv6.ignore-auto-dns=true

    [connection-ethernet]
    match-device=type:ethernet
    ipv4.route-metric=100
    ipv6.route-metric=100
    connection.autoconnect-priority=100

    [connection-wifi]
    match-device=type:wifi
    ipv4.route-metric=600
    ipv6.route-metric=600
    connection.autoconnect-priority=10
  '';

  environment.systemPackages = with pkgs; [
    mtr
    ethtool
    dnsutils
    inetutils
  ];
}
