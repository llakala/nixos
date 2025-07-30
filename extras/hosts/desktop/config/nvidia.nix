{ inputs, lib, ... }:

{
  imports = lib.singleton inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime;

  # This fixes suspend! Important
  hardware.nvidia.powerManagement.enable = true;

  hardware.nvidia.open = true;
}
