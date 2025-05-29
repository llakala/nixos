{ inputs, lib, pkgs, ... }:

{
  imports = lib.singleton inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime;

  # This fixes suspend! Important
  hardware.nvidia.powerManagement.enable = true;

  hardware.nvidia.open = true;

  # Nvidia isn't building on 6.15 right now
  boot.kernelPackages = pkgs.linuxPackages_6_14;
}
