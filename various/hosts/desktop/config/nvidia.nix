{ sources, pkgs, ... }:

{
  imports = [ "${sources.nixos-hardware}/common/gpu/nvidia" ];

  # This fixes suspend! Important
  hardware.nvidia.powerManagement.enable = true;

  hardware.nvidia.open = true;

  # Nvidia isn't building on 6.16 right now
  boot.kernelPackages = pkgs.linuxPackages_6_15;
}
