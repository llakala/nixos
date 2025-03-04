{ inputs, lib, config, ... }:
{

  imports = lib.singleton inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime;

  hardware.nvidia.open = true;
}
