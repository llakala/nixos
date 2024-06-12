{ pkgs-stable, ...}:

{

  imports =
  [
    nixos-hardware.nixosModules.framework-13-7040-amd
  ];
  #fwupd.enable = true; # Bios updates

  environment.systemPackages = with pkgs-stable;
  [
    fprintd
  ];


  fprintd.enable = true; # Fingerprint

  #power-profiles-daemon.enable = true;
}