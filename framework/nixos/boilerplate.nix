{ pkgs-stable, ...}:

{
  fwupd.enable = true; # Bios updates

  environment.systemPackages = with pkgs-stable;
  [
    fprintd
  ];

  
  fprintd.enable = true; # Fingerprint

  power-profiles-daemon.enable = true;
}