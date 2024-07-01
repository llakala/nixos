{ nixos-hardware, ...}:

{



  services =
  {
    fprintd.enable = true; # Fingerprint
    fwupd.enable = true; # bios
    power-profiles-daemon.enable = true; # better power management
  };
}