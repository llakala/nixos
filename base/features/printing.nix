{ lib, ... }:
{
  services.printing.enable = lib.mkForce false; # For CUPS linux vulnerability
  services.avahi.enable = lib.mkForce false;
}
