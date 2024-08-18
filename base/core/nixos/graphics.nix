{ pkgs, ... }:

{
  hardware.opengl =
  {
    enable = true;
    driSupport = true;
    driSupport32Bit = true; # OpenGL for 32 bit apps

    extraPackages = with pkgs; # Vulkan and openCL support with AMD graphics
    [
      rocm-opencl-icd
      rocm-opencl-runtime
    ];
  };
}