{ lib, pkgs, ... }:

{
  services.xserver =
  {
    enable = true;
    excludePackages = with pkgs; [xterm]; # Remove weird xterm
  };
}
