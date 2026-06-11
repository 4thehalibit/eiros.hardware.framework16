{ pkgs, ... }:
{
  # Back to linuxPackages_latest: the MT7922 btmtk BT regression that broke 7.0.8 (and was
  # also present in the 6.6.142 stable backport) is reported fixed in the latest kernel
  # (upstream 61c5a3def90a). Trying latest to get working Bluetooth. If BT oopses again at
  # boot (btusb_mtk_setup -> btmtk_setup_firmware_79xx NULL-deref), fall back to a pinned
  # known-good series.
  eiros.system.boot.kernel.package = pkgs.linuxPackages_latest;
}
