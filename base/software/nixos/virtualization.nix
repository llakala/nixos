{ ... }:

{

  virtualisation.docker.enable = true;

  boot.kernelModules = [ "kvm-amd" ];

  virtualisation =
  {
    libvirtd.enable = true;
  };


}