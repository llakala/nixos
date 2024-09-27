{ lib, ... }:
{
  services.printing.enable = lib.mkForce false;
  services.avahi.enable = lib.mkForce false;
}