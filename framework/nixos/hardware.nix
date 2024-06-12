{ pkgs, pkgs-stable, nixos-hardware, ...}:

{

  #fwupd.enable = true; # Bios updates
  environment.systemPackages = with pkgs;
  [
  ];

  services =
  {
    fprintd.enable = true; # Fingerprint
    fwupd.enable = true;
    power-profiles-daemon.enable = true;
  };
}