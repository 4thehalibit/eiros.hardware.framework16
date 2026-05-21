{ config, lib, ... }:
{
  config = lib.mkMerge [
    {
      eiros.system.hardware.fingerprint_scanner.enable = lib.mkDefault true;
    }
    (lib.mkIf config.eiros.system.hardware.fingerprint_scanner.enable {
      eiros.system.user_defaults.dms.lock_screen.fprint.enable = lib.mkDefault true;
    })
  ];
}
