{ pkgs, ... }:
{
  # Pin to 6.6 LTS to work around Framework 16 BT regression on linuxPackages_latest 7.0.8.
  eiros.system.boot.kernel.package = pkgs.linuxPackages_6_6;
}
