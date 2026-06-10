{ pkgs, ... }:
{
  environment.etc."NetworkManager/conf.d/10-route-priority.conf".text = ''
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
